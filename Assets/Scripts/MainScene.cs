using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MainScene : MonoBehaviour
{
	[SerializeField]
	private Material[] materials;

	private IEnumerator Start()
	{
		// メッシュ生成
		for (int i = 0; i < materials.Length; i++)
		{
			for (int j = 0; j < 4; j++)
			{
				var instance = GameObject.CreatePrimitive((PrimitiveType)j);
				instance.transform.position = new Vector3(i * 2, 0, j * 2);

				var meshRenderer = instance.GetComponent<MeshRenderer>();
				meshRenderer.sharedMaterial = materials[i];
			}
		}

		yield return null;
	}
}
