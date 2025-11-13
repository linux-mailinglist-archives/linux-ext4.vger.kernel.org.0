Return-Path: <linux-ext4+bounces-11855-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7CCC571C6
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Nov 2025 12:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A7263420D2
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Nov 2025 11:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B443337680;
	Thu, 13 Nov 2025 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e3UU9TyP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F702E2663;
	Thu, 13 Nov 2025 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032029; cv=none; b=r+tR30AEK8naGxEl6uLf7Lns9PmvBLgzBnTT2Szh5SZnPp6eiyhdoezUwNmMm2Aa+l3nwfpNKQWjAAuSSF5w5D/Od4Hi0tFkKTLXkHUv4ft1HyLM5fYA2+UnbjRIdF6/NB3/8SVZRKwcBzJbehjbzJHrH33vyf25/Rc2vD3Xii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032029; c=relaxed/simple;
	bh=v/SClx6pDneiH8NjxDA69Lseo/C85tR7TlS11Ig/icg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gucaaiqjVVTRhE8LdwxdRNZPZtMbKpd7eRRUfsEewXO6F4xahFlz2pFHNuz3/pnguf7y+JskJl+Hs4JlUooSwOo0jWx8lgCck0rpq71gIkX03QShX7JdnSUdzDDc8cZg3Wb9c15c6ZhO41V//7rQibBU7N6VWqr8qcatlJI62n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e3UU9TyP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD2Zrtb021035;
	Thu, 13 Nov 2025 11:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=v0SZnCYKi5R08FsOGh+wdrFNkCfbgv
	DcqU5jhlslYdI=; b=e3UU9TyP5eYuElA9R8CKkm4USbwcQunmfQ0h3nFV4FS4nB
	X7ZqkManUZUk2yUh4i16GzRce5M8OuKfuECTujOAaIPb3WAN4A4F4YhTlIHXiq3p
	RgMjaUdq+F/jkcw8ZPyIVsBnne36Y7HvW6wQ3YC8cujyXBilMxlWVNSHA7V/pIoL
	BtQPRlbEzt07oV9CIUIfjhEIc9Vn7MpFwYP+kAbpT5XfbvgB3HWnCdtlWJHzak1C
	yg/l4yyEMzPrs1bJWF1YASdMVGmSui58tHi5kh+6d8n1cFdS7oFAFG4s2/VaHyJl
	DGR8wDSRG8/u+ukUlt3MpZGd+wzzDE+i9GILfU8g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cjebwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 11:06:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD8kgBv007368;
	Thu, 13 Nov 2025 11:06:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajdjn7f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 11:06:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ADB6rjk55837020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 11:06:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0BE120040;
	Thu, 13 Nov 2025 11:06:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A3A120043;
	Thu, 13 Nov 2025 11:06:52 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.211.50])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 13 Nov 2025 11:06:52 +0000 (GMT)
Date: Thu, 13 Nov 2025 16:36:49 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/7] generic/778: fix background loop control with
 sentinel files
Message-ID: <aRW7yWziEnN_kkk5@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <176279908967.605950.2192923313361120314.stgit@frogsfrogsfrogs>
 <176279909060.605950.10294250986845341696.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176279909060.605950.10294250986845341696.stgit@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Ss+dKfO0 c=1 sm=1 tr=0 ts=6915bbd0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=1I0DakYQcCtwVW00KZIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5NSBTYWx0ZWRfX2C1GDFXmLxXV
 Sm5Gxs7Mu36yWdJzl8pRnO1hGqH1TBy3QeSv5bRfON7/xrW8ouafMQZHP9lG0JloFUGsUE76Jn+
 baql0noHEEF3I3Cgssb9XpSLQKEUs2+hukYxdbU8tRf5mdYqYcqAop+mTs/0AOg9AqZW1JdQh8K
 PCqG/wLsiPHKXLbOiOvwtB3Q19Rc+2VPcCVnLG0U4UmZFH9035kmbV5MG48f0mpl+7sHzgvkHjR
 fRCjr0/E0feUild9hMzFH1PGMR7NQ1RHd6dQrjEsnkT7mn3wZ8mzRml/yIYTDhJrf32GpSKWHSu
 XyME7CWksTYFprQJ3M+pmsooQj/b/iTwf8huTIc2elRVCSK8uuVI8HRyNX7StVyHduHGpAzY1kV
 ihovU4ipkTHZy21mnFNYlKlwBo1twg==
X-Proofpoint-GUID: YJVR3fePGEH0PyaM8stqFYH35beUEwqj
X-Proofpoint-ORIG-GUID: YJVR3fePGEH0PyaM8stqFYH35beUEwqj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080095

On Mon, Nov 10, 2025 at 10:26:48AM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This test fails on my slowish QA VM with 32k-fsblock xfs:
> 
>  --- /run/fstests/bin/tests/generic/778.out      2025-10-20 10:03:43.432910446 -0700
>  +++ /var/tmp/fstests/generic/778.out.bad        2025-11-04 12:01:31.137813652 -0800
>  @@ -1,2 +1,137 @@
>   QA output created by 778
>  -Silence is golden
>  +umount: /opt: target is busy.
>  +mount: /opt: /dev/sda4 already mounted on /opt.
>  +       dmesg(1) may have more information after failed mount system call.
>  +cycle mount failed
>  +(see /var/tmp/fstests/generic/778.full for details)
> 
> Injecting a 'ps auxfww' into the _scratch_cycle_mount helper reveals
> that this process is still sitting on /opt:
> 
> root     1804418  9.0  0.8 144960 134368 pts/0   Dl+  12:01   0:00 /run/fstests/xfsprogs/io/xfs_io -i -c open -fsd /opt/testfile -c pwrite -S 0x61 -DA -V1 -b 134217728 134217728 134217728
> 
> Yes, that's the xfs_io process started by atomic_write_loop.
> Inexplicably, the awloop killing code terminates the subshell running
> the for loop in atomic_write_loop but only waits for the subshell itself
> to exit.  It doesn't wait for any of that subshell's children, and
> that's why the unmount fails.

Ouch, thanks for catching this. This approach looks good to me.

Feel free to add:
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> 
> A bare "wait" (without the $awloop_pid parameter) also doesn't wait for
> the xfs_io because the parent shell sees the subshell exit and treats
> that as job completion.  We can't use killall here because the system
> could be running check-parallel, nor can we use pkill here because the
> pid namespace containment code was removed.
> 
> The simplest stupid answer is to use sentinel files to control the loop.
> 
> Cc: <fstests@vger.kernel.org> # v2025.10.20
> Fixes: ca954527ff9d97 ("generic: Add sudden shutdown tests for multi block atomic writes")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  tests/generic/778 |   36 ++++++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
> 
> 
> diff --git a/tests/generic/778 b/tests/generic/778
> index 7cfabc3a47a521..715de458268ebc 100755
> --- a/tests/generic/778
> +++ b/tests/generic/778
> @@ -21,6 +21,9 @@ _scratch_mount >> $seqres.full
>  testfile=$SCRATCH_MNT/testfile
>  touch $testfile
>  
> +awloop_runfile=$tmp.awloop_running
> +awloop_killfile=$tmp.awloop_kill
> +
>  awu_max=$(_get_atomic_write_unit_max $testfile)
>  blksz=$(_get_block_size $SCRATCH_MNT)
>  echo "Awu max: $awu_max" >> $seqres.full
> @@ -31,25 +34,48 @@ num_blocks=$((awu_max / blksz))
>  filesize=$(( 10 * 1024 * 1024 * 1024 ))
>  
>  _cleanup() {
> -	[ -n "$awloop_pid" ] && kill $awloop_pid &> /dev/null
> -	wait
> +	kill_awloop
>  }
>  
>  atomic_write_loop() {
>  	local off=0
>  	local size=$awu_max
> +
> +	rm -f $awloop_killfile
> +	touch $awloop_runfile
> +
>  	for ((i=0; i<$((filesize / $size )); i++)); do
>  		# Due to sudden shutdown this can produce errors so just
>  		# redirect them to seqres.full
>  		$XFS_IO_PROG -c "open -fsd $testfile" -c "pwrite -S 0x61 -DA -V1 -b $size $off $size" >> /dev/null 2>>$seqres.full
> +		if [ ! -w "$testfile" ] || [ -e "$awloop_killfile" ]; then
> +			break
> +		fi
>  		echo "Written to offset: $((off + size))" >> $tmp.aw
>  		off=$((off + size))
>  	done
> +
> +	rm -f $awloop_runfile
> +}
> +
> +# Use sentinel files to control the loop execution because we don't know the
> +# pid of the xfs_io process and so we can't wait for it directly.  A bare
> +# wait command won't wait for a D-state xfs_io process so we can't do that
> +# either.  We can't use killall because check-parallel, and we can't pkill
> +# because the pid namespacing code was removed withotu fixing check-parallel.
> +kill_awloop() {
> +	test -e $awloop_runfile || return
> +
> +	touch $awloop_killfile
> +
> +	for ((i=0;i<300;i++)); do
> +		test -e $awloop_runfile || break
> +		sleep 0.1
> +	done
>  }
>  
>  start_atomic_write_and_shutdown() {
>  	atomic_write_loop &
> -	awloop_pid=$!
>  	local max_loops=100
>  
>  	local i=0
> @@ -70,9 +96,7 @@ start_atomic_write_and_shutdown() {
>  	echo "# Shutting down filesystem while write is running" >> $seqres.full
>  	_scratch_shutdown
>  
> -	kill $awloop_pid 2>/dev/null  # the process might have finished already
> -	wait $awloop_pid
> -	unset $awloop_pid
> +	kill_awloop
>  }
>  
>  # This test has the following flow:
> 

