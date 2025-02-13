Return-Path: <linux-ext4+bounces-6425-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C5FA3378F
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2025 06:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6391516884F
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2025 05:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA5E206F23;
	Thu, 13 Feb 2025 05:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qhILCEtU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D802203713;
	Thu, 13 Feb 2025 05:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739425894; cv=none; b=M9q+AfB6bBvTCL9QGQpnfmoIiREq0pS0i8/8Zf+TqMNOB78g9eDq21VPEN/VKFKCtIBMIIQcWszkXK9wN+Jj0YproqzQ9tQgxpy+7ypwxKdE9VV2edt+4c8T6iLckIl7EYGEbBUNcYCmB1UfEKqUgGWpJ7R7zLYkmEuqPIoHORc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739425894; c=relaxed/simple;
	bh=PkNjVL/kSKW2G53Vi++6tcQrKru/yJOa+Ssg+iRPYI4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=TgzIkFl7KdCQ4sL57AXoDTbAEaN16awN4aOxIGRy7tHIiIpxJvUk3upjjKBtiiEafka34oWOU2zzIIGeJVXaYyPHVc6eU4y6O8M1jTHuPEklr01nDucImYQFYRLZQzXhu9Vh+vMmsSm8Q4Y4bSmikUX6ydAK0h1Tjt0JICAYS/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qhILCEtU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D5OO81001130;
	Thu, 13 Feb 2025 05:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=xaZ/t+lQiDPE97s/kgnZ3zSRS0sI
	WKA73LDpTv3/fI8=; b=qhILCEtUijMZGHopCaxXG+lkaBrZVdgZKfG6CJH09lSG
	3vy0Wy8ZVTqkl85DtH6U6Aefj+/3RlZRsux70qn9LY41oxgh4eTAhRDGJUzBjBsX
	Ohb/2hOUwjZ7DwyvV+P/mnvdZWNP8++0RbT6QrZErOPfJ/Pvo25TdljbZIYqfQNU
	qHltSxPV9OvnDPvl++BvQgw/2/ZfZ+1q961XlTtbWDtNfYAq9rRhlGSdXi1bUwa+
	tSrITkYtQwnw9mFIeYr9xqe0HHCmWJF9rq7CzEHr5CNmFpieOQKXi3/5Msti3doW
	v14IpN4sIY+GXSi/6dua6zqVc2vyiCEfzyCXysyx0A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44saj8g2wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 05:51:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51D5jKU0028716;
	Thu, 13 Feb 2025 05:51:26 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44pma1vawr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 05:51:26 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51D5pPOl32703022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 05:51:25 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9422D58058;
	Thu, 13 Feb 2025 05:51:25 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E79B5805D;
	Thu, 13 Feb 2025 05:51:24 +0000 (GMT)
Received: from [9.61.255.185] (unknown [9.61.255.185])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Feb 2025 05:51:23 +0000 (GMT)
Message-ID: <6f43bd29-d72b-4a39-b931-7b1b47c7cc06@linux.vnet.ibm.com>
Date: Thu, 13 Feb 2025 11:21:22 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, fstests@vger.kernel.org
From: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Subject: [next-20250212] FStests generic/451 on EXT4 FS resulting in kernel
 OOPs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l_Hr_fWDNLwDD9rkdCqusqc-aXGi54_p
X-Proofpoint-ORIG-GUID: l_Hr_fWDNLwDD9rkdCqusqc-aXGi54_p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_02,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=690 impostorscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502130040

Greetings!!!


I am observing kernel OOPs, while running FStests generic/451 on EXT4 
with linux-next kernel(next-20250212) on IBM Power Servers.


Issue is seen on: next-20250212

Issue not seen on: next-20250210


Traces:

[ 2977.768678] run fstests generic/451 at 2025-02-12 16:42:14
[ 3001.242006] list_add double add: new=c00000000e2398c8, 
prev=c00000000e2398c8, next=c0000000c1f2f0b8.
[ 3001.242047] ------------[ cut here ]------------
[ 3001.242052] kernel BUG at lib/list_debug.c:35!
[ 3001.242059] Oops: Exception in kernel mode, sig: 5 [#1]
[ 3001.242065] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=8192 NUMA pSeries
[ 3001.242072] Modules linked in: overlay dm_zero dm_thin_pool 
dm_persistent_data dm_bio_prison dm_snapshot dm_bufio dm_flakey ext4 
mbcache jbd2 loop dm_mod nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib 
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct 
nft_chain_nat nf_nat nf_conntrack bonding nf_defrag_ipv6 nf_defrag_ipv4 
tls ip_set rfkill nf_tables nfnetlink pseries_rng aes_gcm_p10_crypto 
crypto_simd vmx_crypto xfs sr_mod sd_mod cdrom sg ibmvscsi ibmveth 
scsi_transport_srp fuse [last unloaded: scsi_debug]
[ 3001.242165] CPU: 26 UID: 0 PID: 894003 Comm: kworker/u228:17 Not 
tainted 6.14.0-rc2-next-20250212 #1
[ 3001.242174] Hardware name: IBM,8375-42A POWER9 (architected) 0x4e0202 
0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
[ 3001.242183] Workqueue: loop0 loop_workfn [loop]
[ 3001.242194] NIP:  c00000000090d528 LR: c00000000090d524 CTR: 
00000000007088ec
[ 3001.242201] REGS: c0000000e5adfa70 TRAP: 0700   Not tainted 
(6.14.0-rc2-next-20250212)
[ 3001.242208] MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  
CR: 2800024f  XER: 00000009
[ 3001.242229] CFAR: c000000000224238 IRQMASK: 1
[ 3001.242229] GPR00: c00000000090d524 c0000000e5adfd10 c000000001657500 
0000000000000058
[ 3001.242229] GPR04: c000001179a87c88 c000001179a96000 c0000000e5adfb58 
0000001177810000
[ 3001.242229] GPR08: 0000000000000027 0000000000000000 0000000000000000 
0000000000000001
[ 3001.242229] GPR12: c000000002a49cd0 c00000000f75ff00 c0000000001abf00 
c0000000fda72fc0
[ 3001.242229] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[ 3001.242229] GPR20: c000000007acbc00 0000000004208060 c00000000e239880 
fffffffffffffef7
[ 3001.242229] GPR24: 0000000000000402 c0000000924b8fc0 c0000000c1f2f07c 
c0000000c1f2f000
[ 3001.242229] GPR28: c0000000c1f2f0b8 c00000000e2398c8 c00000000e2398c8 
c0000000c1f2f0b8
[ 3001.242309] NIP [c00000000090d528] __list_add_valid_or_report+0x158/0x15c
[ 3001.242318] LR [c00000000090d524] __list_add_valid_or_report+0x154/0x15c
[ 3001.242324] Call Trace:
[ 3001.242327] [c0000000e5adfd10] [c00000000090d524] 
__list_add_valid_or_report+0x154/0x15c (unreliable)
[ 3001.242336] [c0000000e5adfd90] [c0080000073c359c] 
loop_process_work+0x594/0x630 [loop]
[ 3001.242344] [c0000000e5adfe40] [c00000000019dc5c] 
process_one_work+0x1fc/0x4bc
[ 3001.242354] [c0000000e5adfef0] [c00000000019ebec] 
worker_thread+0x344/0x508
[ 3001.242362] [c0000000e5adff90] [c0000000001ac024] kthread+0x12c/0x14c
[ 3001.242370] [c0000000e5adffe0] [c00000000000df98] 
start_kernel_thread+0x14/0x18
[ 3001.242377] Code: 4b916cf9 60000000 0fe00000 7c0802a6 7c641b78 
3c62ffe5 7fe6fb78 7fc5f378 386343a0 f8010090 4b916cd1 60000000 
<0fe00000> 3c4c00d5 38429fd4 fbe1fff8
[ 3001.242407] ---[ end trace 0000000000000000 ]---
[ 3001.284444] pstore: backend (nvram) writing error (-1)
[ 3001.284452]
[ 3002.284455] Kernel panic - not syncing: Fatal exception
[ 3002.431023] Rebooting in 10 seconds..


Regards,

Venkat.


