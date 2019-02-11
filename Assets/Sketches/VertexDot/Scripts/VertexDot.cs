using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VertexDot : MonoBehaviour
{
	[SerializeField]
	private float speed;

	[SerializeField]
	private float moveSpeed;

	[SerializeField]
	private float length;

	[SerializeField]
	private float dotScaleSpeed;

	private void Update()
	{
		var euler = transform.localEulerAngles;
		euler.y += Time.deltaTime * speed;
		transform.localEulerAngles = euler;

		var pos = transform.localPosition;
		pos.z = Mathf.Sin(Time.time * moveSpeed) * length;
		transform.localPosition = pos;

		var renderer = GetComponent<MeshRenderer>();
		renderer.material.SetFloat("_DotScale", Mathf.Lerp(0.001f, 0.01f, (Mathf.Sin(Time.time * dotScaleSpeed) + 1) / 2));
	}
}
