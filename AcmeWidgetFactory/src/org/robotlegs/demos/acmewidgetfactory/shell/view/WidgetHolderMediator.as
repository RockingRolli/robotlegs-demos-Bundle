package org.robotlegs.demos.acmewidgetfactory.shell.view
{
	import flash.display.DisplayObject;
	
	import org.robotlegs.demos.acmewidgetfactory.shell.events.ShellWidgetEvent;
	import org.robotlegs.demos.acmewidgetfactory.shell.model.ActiveWidgetProxy;
	import org.robotlegs.mvcs.FlexMediator;
	
	public class WidgetHolderMediator extends FlexMediator
	{
		[Inject]
		public var view:WidgetHolderView;
		
		[Inject]
		public var activeWidgetProxy:ActiveWidgetProxy;
		
		public function WidgetHolderMediator()
		{
		}
		
		override public function onRegister():void
		{
			addEventListenerTo(eventDispatcher, ShellWidgetEvent.CREATE_WIDGET_COMPLETE, onCreateWidgetComplete);
			addEventListenerTo(eventDispatcher, ShellWidgetEvent.SHUTDOWN_WIDGET_COMPLETE, onShutdownWidgetComplete);
		}
		
		protected function onCreateWidgetComplete(e:ShellWidgetEvent):void
		{
			view.addChild(activeWidgetProxy.getWidget(e.widgetId) as DisplayObject);
		}
		
		protected function onShutdownWidgetComplete(e:ShellWidgetEvent):void
		{
			view.removeChild(activeWidgetProxy.getWidget(e.widgetId) as DisplayObject);
			dispatch(new ShellWidgetEvent(ShellWidgetEvent.REMOVE_WIDGET_COMPLETE, e.widgetId));
		}
	}
}