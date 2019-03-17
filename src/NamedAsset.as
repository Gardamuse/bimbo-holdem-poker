package 
{
	public class NamedAsset 
	{
		
		public var name:String
		public var asset:Class;
		
		public function NamedAsset(asset:Class, name:String="") 
		{
			this.asset = asset;
			this.name = name;
		}
		
	}

}