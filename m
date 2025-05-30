Return-Path: <linux-ext4+bounces-8240-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 301E2AC8825
	for <lists+linux-ext4@lfdr.de>; Fri, 30 May 2025 08:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58DA16E02A
	for <lists+linux-ext4@lfdr.de>; Fri, 30 May 2025 06:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659601F0E4F;
	Fri, 30 May 2025 06:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="SdcdQ5JM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E846F155C87;
	Fri, 30 May 2025 06:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748585565; cv=none; b=QDgJasvhY3I0Nv29rXPVKmG+Nk9iW20f3j4+nRNm213SNKCOGui9n9uje9xrlkEeQetCxYzt20sfNMyPMQZFpCR1AXPJEXlW2muvYg6P3SEdjmI9VXkeuZt1rtmyMmX+K9N/GDjbWQjnFgCYgBLjbvepR0iFG57DykHJg2gVUFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748585565; c=relaxed/simple;
	bh=ECYNbgxonj2G4+hzU1bi3VciBXLLFGdQax1ZuBBKhs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=qhXeD4r4uPNUh5ZFKyezcWv6dvGZagJV+TuZUq4N4u/WDys7YT+My/YqDrJrXNporzJQ2yWPwXjsh2MeEumvBf7bx8Mv67HVbSaz/mGeWHmY2FfJrjvACvton7ftcNZYsdfSMl7G1IhMJdBSJAiJoYt3q0cb/3du1xiSFxLeBvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=SdcdQ5JM reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=LAkcB8Zm4x5NR3cR1LBlgLBoGr+aB51ytzUBOA97MKo=; b=S
	dcdQ5JMoa/I+udGQ7qGm5G+x2WskDxqbGkPT4YrbmBQ0mNMBWKGEjHkzbCsnD5nt
	13McBuXZnJJfNZoInYgm5uSJoe3XNmhvKjE0iiBcL9nv4b4uKe2ixUDKceVU8rKR
	qep8CgbTc3R9s8nRUX3AwPGOpCu4nCnDAoUpXPiFn8=
Received: from 00107082$163.com ( [111.35.189.95] ) by
 ajax-webmail-wmsvr-40-137 (Coremail) ; Fri, 30 May 2025 14:12:27 +0800
 (CST)
Date: Fri, 30 May 2025 14:12:27 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] ext4: use kmem_cache for short fname allocation in
 readdir
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <20250530043516.GD332467@mit.edu>
References: <20250529144256.4517-1-00107082@163.com>
 <20250530043516.GD332467@mit.edu>
X-NTES-SC: AL_Qu2fCvmTuk0v4SifbOkZnEYQheY4XMKyuPkg1YJXOp80iiXw+TwleXBdJFzfwcOmET6tvxevTR985dV8TbNWXZyga29wKsrxG5jtNZnpVpby
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2579f239.5415.1971fd2086a.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:iSgvCgD3X_VMTDlom+0QAA--.9225W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqBJdqmg5RdBhNwADsc
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMDUtMzAgMTI6MzU6MTYsICJUaGVvZG9yZSBUcydvIiA8dHl0c29AbWl0LmVkdT4g
d3JvdGU6Cj5PbiBUaHUsIE1heSAyOSwgMjAyNSBhdCAxMDo0Mjo1NlBNICswODAwLCBEYXZpZCBX
YW5nIHdyb3RlOgo+PiBXaGVuIHNlYXJjaGluZyBmaWxlcywgZXh0NF9yZWFkZGlyIHdvdWxkIGt6
YWxsb2MoKSBhIGZuYW1lCj4+IG9iamVjdCBmb3IgZWFjaCBlbnRyeS4gSXQgd291bGQgYmUgZmFz
dGVyIGlmIGEgZGVkaWNhdGVkCj4+IGttZW1fY2FjaGUgaXMgdXNlZCBmb3IgZm5hbWUuCj4+IAo+
PiBCdXQgZm5hbWVzIGFyZSBvZiB2YXJpYWJsZSBsZW5ndGguCj4+IAo+PiBUaGlzIHBhdGNoIHN1
Z2dlc3RzIHVzaW5nIGttZW1fY2FjaGUgZm9yIGZuYW1lIHdpdGggc2hvcnQKPj4gbGVuZ3RoLCBh
bmQgcmVzb3J0aW5nIHRvIGt6YWxsb2Mgd2hlbiBmbmFtZSBuZWVkcyBsYXJnZXIgYnVmZmVyLgo+
PiBBc3N1bWluZyBsb25nIGZpbGUgbmFtZXMgYXJlIG5vdCB2ZXJ5IGNvbW1vbi4KPj4gCj4+IFBy
b2ZpbGluZyB3aGVuIHNlYXJjaGluZyBmaWxlcyBpbiBrZXJuZWwgY29kZSBiYXNlLCB3aXRoIGZv
bGxvd2luZwo+PiBjb21tYW5kOgo+PiAJIyBwZXJmIHJlY29yZCAtZyAtZSBjcHUtY2xvY2sgLS1m
cmVxPW1heCBiYXNoIC1jIFwKPj4gCSJmb3IgaSBpbiB7MS4uMTAwfTsgZG8gZmluZCAuL2xpbnV4
IC1uYW1lIG5vdGZvdW5kYXRhbGwgPiAvZGV2L251bGw7IGRvbmUiCj4+IEFuZCB1c2luZyBzYW1w
bGUgY291bnRzIGFzIGluZGljYXRvciBvZiBwZXJmb3JtYW5jZSBpbXByb3ZlbWVudC4KPgo+SSB3
b3VsZCB0aGluayBhIGJldHRlciBpbmRpY2F0b3Igb2YgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQg
d291bGQgYmUKPnRvIG1lYXN1cmUgdGhlIHN5c3RlbSB0aW1lIHdoZW4gcnVubmluZyB0aGUgZmlu
ZCBjb21tYW5kcy4gIChpLmUuLAo+ZWl0aGVyIHVzaW5nIGdldHJ1c2FuZ2Ugd2l0aCBSVVNBR0Vf
Q0hJTERSRU4gb3Igd2FpdDMgb3Igd2FpdDQpLgoKSSBkaWQgdXNlIGB0aW1lYCB0byBjb21wYXJl
IHN5c3RlbSB0aW1lIHdoZW4gc2VhcmNoIGZpbGVzIHdpdGggZmluZCwKYW5kIEkgZGlkIHNlZSBz
bGlnaHQgaW1wcm92ZW1lbnQuICAKVGhlIHN0ZCBkZXZpYXRpb24gaXMgcXVpdGUgaGlnaCBmb3Ig
dGhlIHdob2xlIGBmaW5kYCBwcm9jZXNzIHRob3VnaC4KCj4KPldlJ3JlIHRyYWRpbmcgb2ZmIHNv
bWUgZXh0cmEgbWVtb3J5IHVzYWdlIGFuZCBjb2RlIGNvbXBsZXhpdHkgd2l0aAo+bGVzcyBDUFUg
dGltZSBiZWNhdXNlIGVudHJpZXMgaW4gdGhlIGttZW1fY2FjaGUgbWlnaHQgYmUgbW9yZSBUTEIK
PmZyaWVuZGx5LiAgQnV0IHRoaXMgaXMgb25seSByZWFsbHkgZ29pbmcgdG8gYmUgYXBwbGljYWJs
ZSBpZiB0aGUKPmRpcmVjdG9yeSBpcyBsYXJnZSBlbm91Z2ggc3VjaCB0aGF0IHRoZSBjeWNsZXMg
c3BlbnQgaW4gcmVhZGRpciBpcwo+c2lnbmlmaWNhbnQgY29tcGFyZWQgdG8gdGhlIHJlc3Qgb2Yg
dGhlIHVzZXJzcGFjZSBwcm9ncmFtLCAqYW5kKiB5b3UKPmFyZSByZWFkaW5nIHRoZSBkaXJlY3Rv
cnkgbXVsdGlwbGUgdGltZXMgKGUuZy4sIGNhbGxpbmcgZmluZCBvbiBhCj5kaXJlY3RvcnkgaGll
cmFyY2h5IG1hbnksIG1hbnkgdGltZXMpIHN1Y2ggdGhhdCB0aGUgZGlzayBibG9ja3MgYXJlCj5j
YWhlZCBhbmQgeW91IGRvbid0IG5lZWQgdG8gcmVhZCB0aGVtIGZyb20gdGhlIHN0b3JhZ2UgZGV2
aWNlLgo+T3RoZXJ3aXNlIHRoZSBJL08gY29zdHMgd2lsbCBjb21wbGV0ZWx5IGRvbWluYXRlIGFu
ZCBzd2FtcCB0aGUKPm1hcmdpbmFsIFRMQiBjYWNoZSBzYXZpbmdzLgoKWWVzLCB0aGUgdGVzdCB3
YXMgcnVuIHdpdGggY2FjaGUtaG90LiAKQnV0IHJlcGVhdGluZyBzZWFyY2ggZmlsZXMgaXMgbm90
ICB1bmNvbW1vbiBwcmFjdGljZSwgIGBmaW5kYCB3b3VsZCBydW4gd2l0aCBjYWNoZS1ob3QKZXhj
ZXB0IHRoZSBmaXJzdCByb3VuZC4KIAo+Cj5HaXZlbiB0aGF0IGl0J3MgcmVhbGx5IHJhcmUgZm9y
IHJlYWRkaXIoKSB0byBiZSB0aGUgYm90dGxlbmVjayBvZiBtYW55Cj53b3JrbG9hZHMsIHRoZSBx
dWVzdGlvbiBpcywgaXMgaXQgd29ydGggaXQ/CgpUaGF0J3MgdGhlIHF1ZXN0aW9uIEkgaGF2ZSBi
ZWVuIHRoaW5raW5nIGFib3V0LgpCZXNpZGUgbWFyZ2luYWwgaW1wcm92ZW1lbnQgZm9yIHJlYWRk
aXIoKSwgSSB3b3VsZCBhcmd1ZSB3aXRoIHRoZSBpbXBhY3Qgb24gb3RoZXIgcGFydHMgaW4gc3lz
dGVtCndoZW4gc2VhcmNoaW5nIGZpbGVzLiBFdmVuIHdpdGggY2FjaGUtY29kZSwgc2VhcmNoaW5n
IGxhcmdlIGRpciB3b3VsZCBpbnZvbHZpbmcgaGlnaCBmcmVxdWVudCBvZgptYWxsb2MoKSBmb3Ig
YSBzaG9ydCBpbnRlcnZhbCwgIFRoaXMgbWlnaHQgaGF2ZSB0cmFuc2llbnQgbmVnYXRpdmUgaW1w
YWN0ICBvbiBvdGhlcnMgd2hpY2ggYWxzbyByZXF1ZXN0IG1hbGxvYygpLCBidXQgd2l0aApsb3cg
ZnJlcXVlbmN5LiAgQnV0IEkgZG9uJ3QgaGF2ZSBhIGNvbnZpbmNpbmcgZXhhbXBsZXMgZm9yIHRo
aXMsIGl0J3MgYWxsIHRoZW9yZXRpY2FsIC4KCgpUaGFua3MKRGF2aWQKCj4KPgkJCQkJCS0gVGVk
Cg==

