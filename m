Return-Path: <linux-ext4+bounces-8279-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71311ACBCB4
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Jun 2025 23:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326EB17504D
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Jun 2025 21:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F253C39FF3;
	Mon,  2 Jun 2025 21:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SEdo25JG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023087.outbound.protection.outlook.com [40.107.44.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE294400
	for <linux-ext4@vger.kernel.org>; Mon,  2 Jun 2025 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748899946; cv=fail; b=JdrWAi/2vuko6Bxsq1sdvTkLp+DJeqMANh6EW3PlVhYyNkXNLx/gn2szoFDUu5jhATO5bM2YZ+stCx9JFzVibS6nDue7su1iCkm/QvnCwmyy96BV1EMNqTrT9Hyq3dUIF2BFsMc04c/tpb+fuoKb2NCA/kv7gaKTmoWTWdraDhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748899946; c=relaxed/simple;
	bh=JbCzx93vg2Oh/BA3kDJnBciz42BGpPhzqETI6QpZlZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZzUZGGtUAWkdJMM3c/XWC4Im8khsJCiDcbjWPqqCRYIofUxLsyfmYioC2U6cWU7Rnc3CJF0kuGT5Bp6dJOMlLfC68fuJsCb4oksXxfhEh+9YYuDd/abtY2LO8jnzIz1d1DK3NrOzqh026MqPgWBhHD5B7eZkz61nk9FFnaK/q4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=SEdo25JG; arc=fail smtp.client-ip=40.107.44.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNPEOlMBi06CIiLTMA1okOjmHdOH3s30C+D13k9kA8TGp1rAakSuqF3ZkPoI3r4jOkikcaNbn1Ktg+nINWlO9MsRonj1IHon569gIMHNL6nj3tersy0pqEmtHwTtlAzcb5QbdM/9pd7ey2VSmpLV3EUHbm6KE/KXQMs1cjrA/kLJYtr/jjsloUjjAq5B2WbjxpLJLur9NSdqh/LLKG+2+TaW4DxjXIgUGknmOoUuO0ySXt6UV/goQ/W0rGSrMlVu3Z3L7ssZGpwgipv9iK4ewDm8/UQGRsgvOErIVKsYkiEcoU9aiWYgqHWgFJv0U8FIxhZ1IoaSj7Ntw7w64tbESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HFCDXh4nKSA/53dvlz4ZEkhiIbJFJHibFcr7NsVaIk=;
 b=lWudsDTPhGcka+lM0BjuqdwsB4ktTwMT/irux2szUGG7lpdijpx5YAan38bVhybUNv4AK0wAo1JGswQr58Q6GDAF1jDA7FMZQtjGXfKoN68CN/NNGeoeoRDxHiZCjwD+O/56wKgfOp5p4Tm/6BmftZ8vKw8XM6RoPG5Q7sy9+o0Pd7/b2RmagNt4ct+YzemLEVzudwuYwuG9lOpI6cTmAOKmGNFZItS2GYs9fbwj58SFS4ntuRYEHJZpZDwbpKG5FJ9JxMIZTfLUcoucEb95hroVAYVpOfA7ypDpe6Qz2/PcZMfbivvDuucSTWTkNfG9AHxi17QhTJqy9+0g8lJJew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HFCDXh4nKSA/53dvlz4ZEkhiIbJFJHibFcr7NsVaIk=;
 b=SEdo25JG3sDPTGcxDywiK4s55Pug1Jj2lLKo2srJg0t78Dfy82iq2UfK6AxFTu1vicrcgOH3REZ4XSc6fbuWGtkrbhL+AdTHwo/8BrIyaE4O5L9NbahETDbGhNzP57NZ6blsPangOTHhkjNfBmpIawIFfH6+M/2kOLxkq1eqh/o=
Received: from TYZP153MB0627.APCP153.PROD.OUTLOOK.COM (2603:1096:400:25f::12)
 by OSQP153MB1207.APCP153.PROD.OUTLOOK.COM (2603:1096:604:372::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.7; Mon, 2 Jun
 2025 21:32:19 +0000
Received: from TYZP153MB0627.APCP153.PROD.OUTLOOK.COM
 ([fe80::1625:a5f8:c796:ee1]) by TYZP153MB0627.APCP153.PROD.OUTLOOK.COM
 ([fe80::1625:a5f8:c796:ee1%5]) with mapi id 15.20.8813.014; Mon, 2 Jun 2025
 21:32:19 +0000
From: Mitta Sai Chaithanya <mittas@microsoft.com>
To: Theodore Ts'o <tytso@mit.edu>
CC: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, Nilesh Awate
	<Nilesh.Awate@microsoft.com>, Ganesan Kalyanasundaram
	<ganesanka@microsoft.com>, Pawan Sharma <sharmapawan@microsoft.com>
Subject: Re: [EXTERNAL] Re: EXT4/JBD2 Not Fully Released device after unmount
 of NVMe-oF Block Device
Thread-Topic: [EXTERNAL] Re: EXT4/JBD2 Not Fully Released device after unmount
 of NVMe-oF Block Device
Thread-Index: AQHb0VLES057MYZ87kOkGU14tXDGcrPu35cAgAF33d8=
Date: Mon, 2 Jun 2025 21:32:18 +0000
Message-ID:
 <TYZP153MB0627DED95B9B9B2E86D66EFED762A@TYZP153MB0627.APCP153.PROD.OUTLOOK.COM>
References:
 <TYZP153MB06279836B028CF36EB7ED260D761A@TYZP153MB0627.APCP153.PROD.OUTLOOK.COM>
 <20250601220418.GC179983@mit.edu>
In-Reply-To: <20250601220418.GC179983@mit.edu>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-02T21:32:17.120Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZP153MB0627:EE_|OSQP153MB1207:EE_
x-ms-office365-filtering-correlation-id: aca112a0-bc30-44cd-c112-08dda21cf38e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?XWdVI4WY267sOaUgS5UFCCXc8JyqOTvuhDJZTPKzHceSQ2hWEwzbwAds?=
 =?Windows-1252?Q?kLETAjsk7GBgovVSEhjHOLJ4lTn7dal9QFulnkDdQNA1pJQ2a7Kftf0b?=
 =?Windows-1252?Q?PFDY7Z7UGDg/1RaspbZZ2dPO3RuB/n0gmDPkk3peM8krqJr722t5Utbr?=
 =?Windows-1252?Q?i/7vN5fUQP8mvDwrJ2T6BIeQbisiLbIIZbuVmzuuxAa42j9Bo94qSb5a?=
 =?Windows-1252?Q?tHXvahOa753cAuUAlncRkqDEHELSnRvs2RVax/xH05ACKVkTl5iiDZcL?=
 =?Windows-1252?Q?4bo6I4/4lJMzkttdxREm7diRUWDVm+RytWSS4Nb3kw9nv0VRup2+nKsJ?=
 =?Windows-1252?Q?IwSQWJxKC4KDrdNW7Eec9Mjpj28dN7YiCeC3akAEpwmi/cwip2P7lmeb?=
 =?Windows-1252?Q?9Mb24OFibH60w5+MNfAbLCijDCcGF6T5EIOozNiCsihsIpawOCHzkWCi?=
 =?Windows-1252?Q?MZ3zEUMtv0eaStfEQV44MZDwreV/yGYX7O4AFupAyOOfnENsDWo9C7xp?=
 =?Windows-1252?Q?x1DBhmrj3FX3kBE16b9ae551CpwOea0WBr5pWHE19p6ntw79uNyyZ+yD?=
 =?Windows-1252?Q?3qbqq1XiO92Itxu9ZotHAm0wPWgZMlhpmAAvDpbNczInmjTSMYpimmey?=
 =?Windows-1252?Q?a7XFbQzvZBbnR/8Kf6Ep+Kzr0Yz1Vy0pf6a6nSMB1tsNMVaxwfv8GwiO?=
 =?Windows-1252?Q?d8GF8zH3z72vNUsBO3OOPgT+SPM4TkGGws4AG9LXebASDmVRQ26tarpD?=
 =?Windows-1252?Q?spu3PfmzmneDVdeTGlh/Y6QManvE1lmLWUdrICfOJZSTaJ1cruBfFUTF?=
 =?Windows-1252?Q?5H4pOVp7GdT14/Ozqw+Emcf4gWUQTisWlJ4juGGY2r178nDBZVeGggG7?=
 =?Windows-1252?Q?7d8D7DuL916xh9zaKQcHe7QVv7TIijTqkhSIPXaFGySgYz64GrOva2S0?=
 =?Windows-1252?Q?eIMCrmnt8x3519mRMB7qzlPMb6LgjTbPuVHWnjNosgfOloYzMBYQOA75?=
 =?Windows-1252?Q?zbH3HkdPH0aVc9hSsnphWVls34TfOACVfskb6jRyH5hqI7q1rNit43RX?=
 =?Windows-1252?Q?chuYuwDX8RNOuUygPuEC9x9OWQc7yYuFiyHWl2MEkByKTXszTLSvkPga?=
 =?Windows-1252?Q?xQq0bNLWG+F9pZyhuXFdX3pzY6bF7rEMXqoou/uPcDXKkZTu6M0Zr6Tq?=
 =?Windows-1252?Q?OMry52TPTCcR913pnDbI9OH7sbspDObsGjKjO67TQKUqfpHW6LaogOwN?=
 =?Windows-1252?Q?npeAOyQ3qveIaqeB8KSIa/dfviOStp7np9WOwhnqGE8KrjWCo33oI52o?=
 =?Windows-1252?Q?6jDjYWyK6KWBAr0Ee0mMQGvdUyhGPqFcMmVS22VZtjPY0XA4kG1UhSIt?=
 =?Windows-1252?Q?/jsz/XJdMyxdVlzAShdU4nUct+HTtcibvFNZhvbbSA0+0k/AyVAzvCup?=
 =?Windows-1252?Q?LNklPlTTCjXraNyKEBQCvltE8NVAnhxUKkuzSraYRfiPEyO/8ejd0P2c?=
 =?Windows-1252?Q?7yoBuh4o++pz1FdrIfDLlFChNeHusFP4qZ4Ows4d0mtOEoEvaYyF+n+v?=
 =?Windows-1252?Q?cSuyYJBHdT+FjyYipth7RmnKLCC2Mz2j89ydcQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZP153MB0627.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?VDlnWL8AyVXq388DOQfU89zm8QSa2e1d6+T7AFQdLsnKezoX2RjRpXxG?=
 =?Windows-1252?Q?pMeClV23bljJ9JZ3yO0SbGGmp2CFZjsWXDQchB/iEvqCA5b/8h/ucn/w?=
 =?Windows-1252?Q?B5Fw5D/mDwu3L7rRGY0zpygRAanJBxtoh11Jn9v9Ft2JBdnl9ZlE/SiY?=
 =?Windows-1252?Q?Pa56zs9wNBDIo5sHmFG4mHIZR+fLJFAPvrGakzYRvhVH3Z7v+j8rnzpl?=
 =?Windows-1252?Q?XC2bsm3JruUzAgh/6TS/ogXA07jUMeZAKlzqPujSBp5Gb7/0inRaPHMm?=
 =?Windows-1252?Q?zDrHqaFv8IAvJrZCMzSmmA4BZ2oH3WdK2EVDjKUqYTlodR/IiFAz7TRH?=
 =?Windows-1252?Q?Ae9BnLPz2r5/XuftygeXw6bYn+Wn77fXvR36VNrpNPPlCPYds2j9Gghb?=
 =?Windows-1252?Q?3UITrvUp9uhENVhUsnnQB2E82G7bqu4pONevTvLL7n829Wt9d/G504zd?=
 =?Windows-1252?Q?4iTbQxntFFjlKqoQmyh10KZUioo/aHw1lWsXfzPKwmlyGMfVt9gxw/lP?=
 =?Windows-1252?Q?Gak5nNEgC3PThkEzZ5jPm0nq/0WIfL8Z+im7LI3pHp8SNmzBOvSj4nhY?=
 =?Windows-1252?Q?pgudHseq5/0PdXBQz3SQrcKIYtUIt9FEWuGHQCVGtbHaUMCMI5KSdx+m?=
 =?Windows-1252?Q?ovTLU0lqE+F3aWad2ZEO7cf5TweaveE44Eqck1LU8pTt9yw2giHWH27g?=
 =?Windows-1252?Q?X9i5cStnckksHaz+IEQ69iNRm9/F0Zmo1N9VNtT5fyva7mQ9/o5to8Vw?=
 =?Windows-1252?Q?QEitUty/e2NbW8+Kr9lGKxHqb8vb3lgZwnW3jnWxbvlSS/LwFrLAqvqy?=
 =?Windows-1252?Q?ZOLtioYp4ajDrHHLnuVGzXFcd6W/2xRFfYuDKnsxzgUnONauLfnpiuiI?=
 =?Windows-1252?Q?polRO+KXWgrovGMt4d6CtwF9HZMzCgSY37o4vWyyYOx8/nDEse9wGS8D?=
 =?Windows-1252?Q?m/tsvEm2kA1/no2IV4r8yn/v75zDNCc2I/pk1+8h0mTJP7BuaonadAlr?=
 =?Windows-1252?Q?9EaB+MQNo3hsuUxdH/zDnl8hJWp25JN6JsgN7P4Su3DwClA4SIJPe4bS?=
 =?Windows-1252?Q?+Pwneh0OmTjbCaaS17JCbCkaznEjCSyP9MNKO6+jm0zAJyFKUvnCI0Mp?=
 =?Windows-1252?Q?uaosRrnb/DwIRVk4uwgrlaJNiRRDVgstav/loGlom95n8vowSwXr+9ga?=
 =?Windows-1252?Q?R9FO4KQBdZvPNBxYPZToHmM47ZG5xZoj1pjne8FuJttSyz8aWzBKc6nz?=
 =?Windows-1252?Q?51yzD47X+Z9VZVtiCOzcTKrGPhgqWU6M8FV7Cp86IHQLSUNBxqSmYYDh?=
 =?Windows-1252?Q?/0LScHuPQDmQd5jWFmYbELvualDdRZaend1nP/CuHsB8bsKJde61YbvD?=
 =?Windows-1252?Q?6SnqAX68dFmIPIvbCtQeMzPx2Icv34yIUtX231x2TH13Ir7Ao/XHxpLf?=
 =?Windows-1252?Q?vO0gc1Mp4WeWoMg8r1MbROJnMdSff9XGqT+DioEZuFzxkrd/2nv6izwj?=
 =?Windows-1252?Q?Ofsa4uDMp4uvmqefc7Th+LCpZwI5v7dSgc9OzfmwmnCQu6ziVFd/zOyO?=
 =?Windows-1252?Q?avrcUoIQp4nyhJ3YmJIsI373PSUuvuhiq28VRfPTYE2PtHWvnS6sPXUh?=
 =?Windows-1252?Q?YGzL/BSJbpgA7qC9X0Elcq4u?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZP153MB0627.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: aca112a0-bc30-44cd-c112-08dda21cf38e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 21:32:18.4940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6oLq8YUGSmzZMMcmeyY4kVCm/apItpIcsOz8r/LKdzlwkHh8g8DHtfTKJZ7iESN+WWDNmNZTFhVV600F+8mTTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQP153MB1207

Hi Ted,=0A=
=A0 =A0 =A0 =A0 =A0 =A0Thanks for your quick response. You're right that we=
 use a bind mount; however,=0A=
I'm certain that we first unmount the bind mount before unmounting the orig=
inal mount.=0A=
I also checked in a different namespace and couldn't find any reference tha=
t NVMe device being mounted.=0A=
=0A=
>  2025-06-01T10:01:11.568304+00:00 aks-nodepool1-44537149-vmss000002 kerne=
l: [30452.346875] nvme nvme0: Failed reconnect attempt 6=0A=
>  Rather, that _apparently_ ext4/jbd2 is issuing I/O's after the NVMe-OF c=
onnection has been torn down.=0A=
=0A=
Yes, I am reproducing the issue and expected to see connection outage error=
s for a few seconds (i.e., within the tolerable time frame).=0A=
However, after the connection is re-established and the device is unmounted=
 from all namespaces, I still observe errors from both ext4 and jb2=0A=
when the device is especially disconnected.=0A=
=0A=
=0A=
>So when you say that /proc/fs/ext4/<device_name> still exists, that is an=
=0A=
> indication that "struct super" for that particular ext4 file system is=0A=
> still alive, and so of course, there can still be ext4 and jbd2 I/O=0A=
> activity happening.=0A=
=0A=
So even when no user-space process is holding the device, and it has been u=
nmounted from all namespaces, mounts and bind mounts,=0A=
is there still a possibility of I/O occurring on the device? If so, how lon=
g does the kernel typically take to flush any remaining I/O operations,=0A=
whether from ext4 or jb2?=0A=
=0A=
Another point I would like to mention, I am observing JBD2 errors especiall=
y after NVMe-oF device has been disconnected and below are the logs.=0A=
=0A=
Logs:=0A=
=0A=
[Wed May 14 16:58:50 2025] nvme nvme0: Removing ctrl: NQN "nqn.2019-05.io.o=
penebs:4cde20d8-ed8f-47ef-90c7-8cf9521a5734"=0A=
[Wed May 14 16:58:50 2025] Buffer I/O error on dev nvme0n1, logical block 1=
081344, lost sync page write=0A=
[Wed May 14 16:58:50 2025] JBD2: Error -5 detected when updating journal su=
perblock for nvme0n1-8.=0A=
[Wed May 14 16:58:50 2025] Aborting journal on device nvme0n1-8.=0A=
[Wed May 14 16:58:50 2025] blk_update_request: recoverable transport error,=
 dev nvme0n1, sector 8650752 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio c=
lass 0=0A=
[Wed May 14 16:58:50 2025] Buffer I/O error on dev nvme0n1, logical block 1=
081344, lost sync page write=0A=
[Wed May 14 16:58:50 2025] JBD2: Error -5 detected when updating journal su=
perblock for nvme0n1-8.=0A=
[Wed May 14 16:58:50 2025] EXT4-fs error (device nvme0n1): ext4_put_super:1=
205: comm ig: Couldn't clean up the journal=0A=
[Wed May 14 16:58:50 2025] blk_update_request: recoverable transport error,=
 dev nvme0n1, sector 0 op 0x1:(WRITE) flags 0x23800 phys_seg 1 prio class 0=
=0A=
[Wed May 14 16:58:50 2025] Buffer I/O error on dev nvme0n1, logical block 0=
, lost sync page write=0A=
[Wed May 14 16:58:50 2025] EXT4-fs (nvme0n1): I/O error while writing super=
block=0A=
[Wed May 14 16:58:50 2025] EXT4-fs (nvme0n1): Remounting filesystem read-on=
ly=0A=
[Wed May 14 16:58:50 2025] blk_update_request: recoverable transport error,=
 dev nvme0n1, sector 0 op 0x1:(WRITE) flags 0x23800 phys_seg 1 prio class 0=
=0A=
[Wed May 14 16:58:50 2025] Buffer I/O error on dev nvme0n1, logical block 0=
, lost sync page write=0A=
[Wed May 14 16:58:50 2025] EXT4-fs (nvme0n1): I/O error while writing super=
block=0A=
=0A=
=0A=
=0A=
Thanks & Regards,=0A=
Sai=0A=
=0A=
=0A=
=0A=
=0A=
________________________________________=0A=
From:=A0Theodore Ts'o <tytso@mit.edu>=0A=
Sent:=A0Monday, June 02, 2025 03:34=0A=
To:=A0Mitta Sai Chaithanya <mittas@microsoft.com>=0A=
Cc:=A0linux-ext4@vger.kernel.org <linux-ext4@vger.kernel.org>; Nilesh Awate=
 <Nilesh.Awate@microsoft.com>; Ganesan Kalyanasundaram <ganesanka@microsoft=
.com>; Pawan Sharma <sharmapawan@microsoft.com>=0A=
Subject:=A0[EXTERNAL] Re: EXT4/JBD2 Not Fully Released device after unmount=
 of NVMe-oF Block Device=0A=
=0A=
=0A=
[You don't often get email from tytso@mit.edu. Learn why this is important =
at https://aka.ms/LearnAboutSenderIdentification=A0]=0A=
=0A=
=0A=
=0A=
On Sun, Jun 01, 2025 at 11:02:05AM +0000, Mitta Sai Chaithanya wrote:=0A=
=0A=
> Hi Team,=0A=
=0A=
>=0A=
=0A=
> I'm encountering journal block device (JBD2) errors after unmounting=0A=
=0A=
> a device and have been trying to trace the source of=0A=
=0A=
> these errors. I've observed that these JBD2 errors only=0A=
=0A=
> occur if the entries under /proc/fs/ext4/<device_name> or=0A=
=0A=
> /proc/fs/jbd2/<device_name> still exist even after a=0A=
=0A=
> successful unmount (the unmount command returns success).=0A=
=0A=
=0A=
=0A=
What you are seeing is I/O errors, not jbd2 errors.=A0 i.e.,=0A=
=0A=
=0A=
=0A=
> 2025-06-01T10:01:11.568304+00:00 aks-nodepool1-44537149-vmss000002 kernel=
: [30452.346875] nvme nvme0: Failed reconnect attempt 6=0A=
=0A=
=0A=
=0A=
These errors may have been caused by the jbd2 layer issuing I/O=0A=
=0A=
requests, but these are not failures of the jbd2 subsystem. =A0Rather,=0A=
=0A=
that _apparently_ ext4/jbd2 is issuing I/O's after the NVMe-OF=0A=
=0A=
connection has been torn down.=0A=
=0A=
=0A=
=0A=
It appears that you are assuming once umount command/system call has=0A=
=0A=
successfuly returned, that the kernel file system will be done sending=0A=
=0A=
I/O requests to the block device.=A0 This is simply not true.=A0 For=0A=
=0A=
example, consider what happens if you do something like:=0A=
=0A=
=0A=
=0A=
# mount /dev/sda1 /mnt=0A=
=0A=
# mount --bind /mnt /mnt2=0A=
=0A=
# umount /mnt=0A=
=0A=
=0A=
=0A=
The umount command will have returned successfully, but the ext4 file=0A=
=0A=
system is still mounted, thanks to the bind mount.=A0 And it's not just=0A=
=0A=
bind mounts.=A0 If you have one or more processes in a different mount=0A=
=0A=
namespace (created using clone(2) with the CLONE_NEWNS flag) so long=0A=
=0A=
as those processes are active, the file system will stay active=0A=
=0A=
regardless of the file system being unounted in the original mount=0A=
=0A=
namespace.=0A=
=0A=
=0A=
=0A=
Internally inside in the kernel, this is the distinction between the=0A=
=0A=
"struct super" object, and the "struct vfsmnt" object.=A0 The umount(2)=0A=
=0A=
system call removes the vfsmnt object from a mount namespace object,=0A=
=0A=
and decrements the refcount of the vfsmnt object.=0A=
=0A=
=0A=
=0A=
The "struct super" object can not be deleted so long as there is at=0A=
=0A=
least one vfsmnt object pointing at the "struct super" object.=A0 So=0A=
=0A=
when you say that /proc/fs/ext4/<device_name> still exists, that is an=0A=
=0A=
indication that "struct super" for that particular ext4 file system is=0A=
=0A=
still alive, and so of course, there can still be ext4 and jbd2 I/O=0A=
=0A=
activity happening.=0A=
=0A=
=0A=
=0A=
> I'd like to understand how to debug this issue further to determine=0A=
=0A=
> the root cause. Specifically, I=92m looking for guidance on what=0A=
=0A=
> kernel-level references or subsystems might still be holding on to=0A=
=0A=
> the journal or device structures post-unmount, and how to trace or=0A=
=0A=
> identify them effectively (or) is this has fixed in latest versions=0A=
=0A=
> of ext4?=0A=
=0A=
=0A=
=0A=
I don't see any evidence of anything "wrong" that requires fixing in=0A=
=0A=
the kernel.=A0 It looks something or someone assumed that the file=0A=
=0A=
system was deactivated after the umount and then tore down the NVMe-OF=0A=
=0A=
TCP connection, even though the file system was still active,=0A=
=0A=
resulting in those errors.=0A=
=0A=
=0A=
=0A=
But that's not a kernel bug; but rather a bug in some human's=0A=
=0A=
understanding of how umount works in the context of bind mounts and=0A=
=0A=
mount namespaces.=0A=
=0A=
=0A=
=0A=
Cheers,=0A=
=0A=
=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - Ted=0A=
=0A=

