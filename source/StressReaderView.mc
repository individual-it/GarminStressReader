import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Timer;

class StressReaderView extends WatchUi.View {
    var timer as Timer.Timer;

    function initialize() {
        timer = new Timer.Timer();
        View.initialize();
    }

    function scheduleTimer() as Void {
        timer.start(method(:onTimerTimeout), 10000 /* milliseconds */, false /* don't repeat */);
    }
    function onTimerTimeout() as Void {
        WatchUi.requestUpdate();
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        var currentStress = getCurrentStress();
        if (currentStress == null) {
            currentStress = "null";
        }
        dc.drawText(
            dc.getWidth() / 2, dc.getHeight()/2,
            Graphics.FONT_LARGE,
            currentStress.toString(),
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    function getCurrentStress() as Integer? {
        var stressValue = null;
        var stressIterator = Toybox.SensorHistory.getStressHistory({:period=>1});
        var sample = stressIterator.next();
        while (sample != null) {
            stressValue = Math.round(sample.data as Float).toNumber();
            sample = stressIterator.next();
        }
    return stressValue;
}

}
