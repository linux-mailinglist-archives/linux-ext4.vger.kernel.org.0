Return-Path: <linux-ext4+bounces-1480-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AF886F083
	for <lists+linux-ext4@lfdr.de>; Sat,  2 Mar 2024 14:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C4B2818B3
	for <lists+linux-ext4@lfdr.de>; Sat,  2 Mar 2024 13:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC27817561;
	Sat,  2 Mar 2024 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="XKSBOxC2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E9A7EC
	for <linux-ext4@vger.kernel.org>; Sat,  2 Mar 2024 13:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709385412; cv=none; b=W88A+ey/UXd+UiJubCzpoRlENrqM68xruEh2xjN4NBBxdJCdaZrKI1f8/dNAtXh8gqK2KVjcmvOkQtkN3ngIo0OfrCD9rckoqmHRnH4f7mA+NdzaSp/fljyYWVYX2hPuUaK46ywo8Rt9cyirkbURTqiN5kOxsoEbPRQQYMmQniU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709385412; c=relaxed/simple;
	bh=lTbaBEijgFSTcVtgE6xju85T+E0Dm7qBzQBmqEsCUns=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Wkc/8SVQjWzHIrr8p5SGES+Y4mdFbiiicUsznsN6AQiLrppsEXlcyw0asecrvgXZSHOCBO5KVOmAzIqPAf2qJ46mOkZQOgiWWN6JY+PogQF5Q2QxcjWFfGCSmUNEbmIs9Z+H298x3v9v4G3ZxBQ8VM2y8brtuwhblcH2Eo3sL5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=XKSBOxC2; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1709385405; x=1709990205; i=wahrenst@gmx.net;
	bh=lTbaBEijgFSTcVtgE6xju85T+E0Dm7qBzQBmqEsCUns=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=XKSBOxC2V3xS1nTb98xv2FnOKdveNT1dfci5XsztC/c+CvcYTiNWfXJmUVEppf2g
	 rn4RnHp6URSTouIuJapy+X3FNgNAj36mNiEOrU/po2zCVQAHSG4XbOEkUBcCM5D60
	 ZM/c7X8Z2mYNleAAzFQAvQz69AsmvfVS3frZAcgNqhceq/K26EeAg0dVw8JcpgRpu
	 uoHHrOBmpRIR/UjyNvSK85MsfcaV4cpqP6Kzj/knpw55zDq6YRV7xnN1kreTAdNlH
	 r5BPe3UxP38tdyc1m5feL6SV3gi9IfACWxgy7SVlXtNCaQ6qULqX8cdDQTE6UR9f9
	 y1ZRhjnl5IQkEkeejw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtwUm-1qt7Sb0dsS-00uFbc; Sat, 02
 Mar 2024 14:16:45 +0100
Message-ID: <bac377c2-ccc2-4cc3-974e-01cdf3f14af7@gmx.net>
Date: Sat, 2 Mar 2024 14:16:44 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org
From: Stefan Wahren <wahrenst@gmx.net>
Subject: KCSAN: data-race in ext4_da_write_end / mpage_process_page_bufs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9l26GwHHWow4WBzHL6iuhJzrdi1w3yF8EuGgYOzK7V3+95S71GZ
 gd2HrPQ+4q9K4csKfoSs9LNWdJOwOk8+fg/Dfndu00IIpXp83ihCTr1wr7t4Dtp6994IHKY
 NpkvawUBBWn8i5vWbPtd/j5cqzdCbF1Z5rm7rrFxy4nfvQxui59gZoPP3btFP5P9FXNSFLY
 LtgfCs269ZSrlhtSPHTOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XdAJ/S+ag8A=;WxrfU9+oO/3CVqv0teiEbt0ggsB
 iE8ujCtGlI6mEAf30a21o7z/3LRyozEgnZpdg0+QTxPSxbl9tJ1Mje4c65U+BDk1X3PtTTnpc
 DxEoWIwsD+qBqTwF3S603MAVWRMjTZy/FaFoi2FGUR0mvf5Iz/srDf7/AX1Y2K2KVVctTz9dp
 Vogruh7QiOfAsmYeEkgL0kupIxArVZ9F5BUHQIV3SbJYWeBeH81JU95jHl01Z9hb2NkPV0hOp
 yie2yYv2ewW/XFuTI0IsvIKMfRATYPiCw624K1saq/fSi0EP06Jea9MZURgSnjuR1Ua1vNPLE
 KtJwOAUHoVWLBldp++iHAVKcAopKJcH0QOiLwbrityoZC1j0GG/waued7MCN0RG6rF3eZxb2u
 Rsk2h0GOllAUKmwnDsYdJ+WcPvEgSFoEu04cNOFKk9shsuq3i3D26cKXGBfruf99iKiI7YyLD
 GE7j+bK7jX6oi1dTyuIECFIPhTyplNQPaOkZPYpCkKYnn7fiF5W6mbiS950hSUgDda2u1y3C2
 7q01/LABqE5tUWbTXfn14QCosYsMaP3GxBnvuysilORw8ZhhcDP2ziIDgffW8yIdYRttsg+Hz
 pPcZjPSm/5Zus3yBvx5g0Aet/FGAt+jCKwx3ZLCm6tfxFFIlK6x22q5euFzwdEDl+8S4R/H0t
 7U/ET4J7n+CKuWCeBZgaS3mKAsCAUZNfyIsGOkmljsIUgJqWdSnuimP/zCMf/lGowZ+flMzk+
 PbPK0o8I09DoCLdNXF5s4UQr6+cf1xrO6830Oq4orpJuvPhUOOFLbYUs9iS0gbHPJUfWs+NAy
 Ryukt7M3QcYBQfwxWjZh4kXzjUKiokFNL9GCtiZGRt3r0=

Hi,
i enabled KCSAN for Linux 6.6.19 on Raspberry Pi 3 B+ (arm64/defconfig)
and after installing a Debian packaging on the ext4 rootfs the following
has been triggered in the kernel log:

[ 1389.056656]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 1389.056781] BUG: KCSAN: data-race in ext4_da_write_end /
mpage_process_page_bufs

[ 1389.056926] write to 0xffff29ba65896a68 of 8 bytes by task 1447 on cpu =
1:
[ 1389.056989]=C2=A0 ext4_da_write_end+0xe4/0x43c
[ 1389.057058]=C2=A0 generic_perform_write+0x1c0/0x2dc
[ 1389.057161]=C2=A0 ext4_buffered_write_iter+0x90/0x198
[ 1389.057246]=C2=A0 ext4_file_write_iter+0x98/0x84c
[ 1389.057328]=C2=A0 vfs_write+0x374/0x4bc
[ 1389.057398]=C2=A0 ksys_write+0x84/0x138
[ 1389.057467]=C2=A0 __arm64_sys_write+0x44/0x58
[ 1389.057539]=C2=A0 invoke_syscall+0x60/0x180
[ 1389.057636]=C2=A0 el0_svc_common.constprop.0+0x78/0x14c
[ 1389.057735]=C2=A0 do_el0_svc+0x34/0x44
[ 1389.057827]=C2=A0 el0_svc+0x38/0x70
[ 1389.057914]=C2=A0 el0t_64_sync_handler+0x13c/0x158
[ 1389.058007]=C2=A0 el0t_64_sync+0x190/0x194

[ 1389.058109] read to 0xffff29ba65896a68 of 8 bytes by task 939 on cpu 0:
[ 1389.058172]=C2=A0 mpage_process_page_bufs+0x54/0x308
[ 1389.058268]=C2=A0 mpage_prepare_extent_to_map+0x670/0x81c
[ 1389.058337]=C2=A0 ext4_do_writepages+0x5bc/0xf78
[ 1389.058405]=C2=A0 ext4_writepages+0xf4/0x1a4
[ 1389.058471]=C2=A0 do_writepages+0xb8/0x294
[ 1389.058557]=C2=A0 __writeback_single_inode+0x54/0x270
[ 1389.058628]=C2=A0 writeback_sb_inodes+0x374/0x6ac
[ 1389.058697]=C2=A0 __writeback_inodes_wb+0x68/0x150
[ 1389.058767]=C2=A0 wb_writeback.isra.0+0x228/0x258
[ 1389.058837]=C2=A0 wb_workfn+0x3e4/0x618
[ 1389.058904]=C2=A0 process_one_work+0x314/0x53c
[ 1389.058993]=C2=A0 worker_thread+0x628/0x7e4
[ 1389.059080]=C2=A0 kthread+0x1c0/0x1c4
[ 1389.059156]=C2=A0 ret_from_fork+0x10/0x20

[ 1389.059262] value changed: 0x0000000002a34000 -> 0x0000000002a35000

[ 1389.059347] Reported by Kernel Concurrency Sanitizer on:
[ 1389.059390] CPU: 0 PID: 939 Comm: kworker/u8:1 Not tainted 6.6.19 #2
[ 1389.059466] Hardware name: Raspberry Pi 3 Model B Plus Rev 1.3 (DT)
[ 1389.059519] Workqueue: writeback wb_workfn (flush-179:0)
[ 1389.059631]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I hope this isn't a false positive and helpful.

Regards

