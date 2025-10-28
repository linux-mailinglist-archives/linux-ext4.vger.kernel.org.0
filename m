Return-Path: <linux-ext4+bounces-11107-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A29FFC13695
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Oct 2025 08:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C46F64EDFEB
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Oct 2025 07:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF212D46A1;
	Tue, 28 Oct 2025 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Iex64U4N"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C590E2D3737;
	Tue, 28 Oct 2025 07:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761638233; cv=none; b=N7rd+XYdXUZ7NSf+6iyqkqf+iuQUOJDQpV2Sf1qi4I5Rj/D4zKWiEhXY6N6/NMdswxvbvtvWqjXYQy/dlKix6yjjuAcU3yTrPUtishOXL+aYjWOFb94Rr+3Hl547rROzOBN2Vy7AUcHp9sDfKleELYEfyCmQyH+DuyTtIPaiFFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761638233; c=relaxed/simple;
	bh=aPaHvwQqxHXcG2ooOSW0MSKj9K8N0Z+319HUs2uwu2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TrluxS6enc9gBDQT084hZtC3G2+Btv0c6BRXmsSi2ENDP5w1QiujOMLTUvJBrWDWTNLdG01PErvmoBbfi1Vf6K9EsqxqAqdcA7wEqpl+Xy9YqLV/NQgVYU1wpG/hoG7v/egc22R/D/4DSO7kLWrupLWqVzeejv1jncKApiA0iFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Iex64U4N; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mzIEzxZKKSUxjAF8Jl1kzUGL9uNKfCGZgWwVYeobzuY=;
	b=Iex64U4N0FsFVHmKUmlg+XPjekFv5Vaqb6sk4HF0Q2kfN3ee21jqTVHiiV6Gy7UTsnjewOu7C
	HoC9ssMiWXLxzEP813QSbhKliZnCjfLX8VN3F+SLk2RqQgBB1Xx9Sg4R+MbOcw9+BhRHGiERxxh
	L17KYIqHwl/MmICvgyLMUPs=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4cwjPb1JmDz1K9D8;
	Tue, 28 Oct 2025 15:56:35 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id AF8141800B2;
	Tue, 28 Oct 2025 15:57:02 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Oct
 2025 15:57:01 +0800
Message-ID: <89dbd368-4e76-45b5-8c82-9102db9f302e@huawei.com>
Date: Tue, 28 Oct 2025 15:57:00 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4/048: Fix hangup due to no free inodes
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
	<fstests@vger.kernel.org>
CC: Leah Rumancik <lrumancik@google.com>, <linux-ext4@vger.kernel.org>, Yang
 Erkun <yangerkun@huawei.com>
References: <20251028071743.1507168-1-ojaswin@linux.ibm.com>
Content-Language: en-GB
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251028071743.1507168-1-ojaswin@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-10-28 15:17, Ojaswin Mujoo wrote:
> We currently mkfs a 128MB filesystem, which gives use ~2048 free inodes
> on 64k blocksize. The test then keeps adding new files to a directory to
> trigger an htree split. For 64k this takes more than the total free
> inodes, which causes touch to return -ENOSPC. This leads to the while
> loop in induce_node_split() to never finish.
>
> To fix this:
> 1. Format a 1G FS which gives us atleast 16K inodes to work with.
> 2. _fail if there's any error while trying to induce node split, so we
>    dont get stuck in loop
>
> Fixes: 466ddbfd1151 ("ext4: add test for ext4_dir_entry2 wipe")
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---

Yeah, I also hit this issue when testing LBS — file creation kept failing
without breaking out of the loop, which resulted in the test case spinning
endlessly.

Looks good to me. Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>

>  tests/ext4/048 | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tests/ext4/048 b/tests/ext4/048
> index 2031c8c8..6343ff3a 100755
> --- a/tests/ext4/048
> +++ b/tests/ext4/048
> @@ -69,6 +69,11 @@ induce_node_split() {
>  	while [[ "$(stat --printf="%s" $testdir)" == "$dir_size" ]]; do
>  		file_num=$(($file_num + 1))
>  		touch $testdir/test"$(printf "%04d" $file_num)"
> +		local ret=$?
> +		if [[ $ret -ne 0 ]]
> +		then
> +			_fail "ERROR induce_node_split(): $ret"
> +		fi
>  	done
>  	_scratch_unmount >> $seqres.full 2>&1
>  }
> @@ -81,7 +86,7 @@ test_file1="test0001"
>  test_file2="test0002"
>  test_file3="test0003"
>  
> -_scratch_mkfs_sized $((128 * 1024 * 1024)) >> $seqres.full 2>&1
> +_scratch_mkfs_sized $((1 * 1024 * 1024 * 1024)) >> $seqres.full 2>&1
>  
>  # create scratch dir for testing
>  # create some files with no name a substr of another name so we can grep later



