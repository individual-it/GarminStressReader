import Toybox.ActivityRecording;
import Toybox.Lang;


class StressReaderDelegate extends Toybox.WatchUi.BehaviorDelegate {

    private var _session as Session?;

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() as Boolean  {
        Toybox.System.println("onSelect");
        _session = ActivityRecording.createSession({:name=>"Nap", :sport=>ActivityRecording.SPORT_GENERIC});
        
        _session.start();

        return true;
    }

    function onNextPage() as Boolean {
        Toybox.System.println("onNextPage");
        _session.stop();
        _session.save();
        return true;
    }
}