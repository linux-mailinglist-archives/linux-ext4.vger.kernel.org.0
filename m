Return-Path: <linux-ext4+bounces-3883-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7F595DB6F
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Aug 2024 06:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201481C221A9
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Aug 2024 04:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1904D3A1CD;
	Sat, 24 Aug 2024 04:20:36 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB2C182B4;
	Sat, 24 Aug 2024 04:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724473235; cv=none; b=UefDZt9IQxPB1HqoATiCqkCbKn8F6XAOpMb4HSR6IdBdxgcZq+C806TcEiKYwFI8ob6lDwthmDsOLLMvJstGsLi2Zich6Ut/99keOYC5dm6fN6ofxEtnyZJc7ZTRK3T29bSme76TCqGzV9oT/buU04JTBPgdaNveXcYoIX5QJGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724473235; c=relaxed/simple;
	bh=+TYfZQw6LeoLTkTwEtsL60r2b1nBCnIkZZlV2NskKyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tqBmvvVRKxl2sFjiDAZU/Us3QlG+El9XZ9H58gGOEW5ERCUI6+fQpZopHePezsYvNVsAmzlDl6wyIdCg83fODifasLh8RV47cznw4NStsRymWK3ITmmpaxZirvOHJt8RsztPE7Ob5MZlqJiSJ07VYDXhgo9W2AcQogEbAaA4Rtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WrNsC0DQrz20m9c;
	Sat, 24 Aug 2024 12:15:43 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (unknown [7.185.36.148])
	by mail.maildlp.com (Postfix) with ESMTPS id AD07814022D;
	Sat, 24 Aug 2024 12:20:27 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.174) by dggpeml100021.china.huawei.com
 (7.185.36.148) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 24 Aug
 2024 12:20:27 +0800
Message-ID: <0dbb903b-7d13-494f-bba4-962820d561b6@huawei.com>
Date: Sat, 24 Aug 2024 12:20:26 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: No need to continue when the number of entries is 1
To: Theodore Ts'o <tytso@mit.edu>
CC: Edward Adam Davis <eadavis@qq.com>,
	<syzbot+ae688d469e36fb5138d0@syzkaller.appspotmail.com>,
	<adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
References: <00000000000075a135061c0480d0@google.com>
 <tencent_BE7AEE6C7C2D216CB8949CE8E6EE7ECC2C0A@qq.com>
 <172433877725.370733.2330809797744892142.b4-ty@mit.edu>
 <6ba9afc8-fa95-478c-8ed2-a4ad10b3c520@huawei.com>
 <20240823160518.GA424729@mit.edu>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240823160518.GA424729@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml100021.china.huawei.com (7.185.36.148)

On 2024/8/24 0:05, Theodore Ts'o wrote:
> On Fri, Aug 23, 2024 at 10:22:19AM +0800, Baokun Li wrote:
>> I think this patch is wrong and it will hide the real problem.
>>
>> The maximum length of a filename is 255 and the minimum block size is 1024,
>> so it is always guaranteed that the number of entries is greater than or
>> equal to 2 when do_split() is called.
>>
>> The problem reported by syzbot was actually caused by a missing check in
>> make_indexed_dir(). The issue has been fixed:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=50ea741def58
>>
>> So unless ext4_dx_add_entry() and make_indexed_dir(), or some other function
>> has a bug, 'split == 0' will not occur.
>>
>> If we want to defend against future changes that introduce bugs, I think
>> it's better to add a WARN_ON_ONCE to make sure that the problem isn't hidden
>> and that it doesn't trigger serious bugs like out-of-bounds access.
> I agree that given your patch (50ea741def58: "ext4: check dot and
> dotdot of dx_root before making dir indexed") split should never be
> zero.  (Although there are two ways this could happen --- either count
> could be 0, or count == max).  But this patch isn't wrong per se
> because in the case where split == 0, we do want to prevent the
> out-of-bounds memory access bug.


Agreed, it is correct to avoid serious problems by judging the split,

I was thinking that it is wrong to report no error or hint when split == 0.

> That being said; adding a WARN_ON_ONCE(split == 0) might be a good
> idea, although I'd probably also print more debugging information so
> we can take a look at the file system and understand what might have
> happened.  Maybe something like this?
>
> 	if (WARN_ON_ONCE(split == 0)) {
> 	   	/* should never happen, but... */
> 		ext4_error_inode_block(dir, (*bh)->b_blocknr, 0,
> 				"bad indexed directory? hash=%08x:%08x "
> 				"count=%d move=%u", hinfo->hash, hinfo->minor_hash,
> 				count, move);
> 		brelse(*bh);
> 		brelse(bh2);
> 		*bh = 0;
> 		return ERR_PTR(-EFSCORRUPTED);
> 	}
>
> I haven't checked to make sure all of the error code paths / error
> handling right, but something like this might be useful for debugging
> purposes --- if the file system developer could get access to the file
> system moment the error is logged.  If the data center automation
> causes the file system to get fsck'ed or reformatted right away (which
> is the only scalable thing to do if there are millions of file systems
> in production :-), something like this is probably not going to help
> all that much.  Still, it certainly wouldn't hurt.

Totally agree! These printouts are very useful for debugging.

The modification above looks good. I tested it and it works fine.

But I think we could reuse the error handling code like this:


diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index e6769b97a970..0187910108c4 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1997,6 +1997,15 @@ static struct ext4_dir_entry_2 *do_split(handle_t 
*handle, struct inode *dir,
         else
                 split = count/2;

+       if (WARN_ON_ONCE(split == 0)) {
+               /* should never happen, but... */
+               ext4_error_inode_block(dir, (*bh)->b_blocknr, 0,
+                               "bad indexed directory? hash=%08x:%08x 
count=%d move=%u",
+                               hinfo->hash, hinfo->minor_hash, count, 
move);
+               err = -EFSCORRUPTED;
+               goto out;
+       }
+
         hash2 = map[split].hash;
         continued = hash2 == map[split - 1].hash;
         dxtrace(printk(KERN_INFO "Split block %lu at %x, %i/%i\n",
@@ -2040,10 +2049,11 @@ static struct ext4_dir_entry_2 
*do_split(handle_t *handle, struct inode *dir,
         return de;

  journal_error:
+       ext4_std_error(dir->i_sb, err);
+out:
         brelse(*bh);
         brelse(bh2);
         *bh = NULL;
-       ext4_std_error(dir->i_sb, err);
         return ERR_PTR(err);
  }

>
> If someone does think this would be helpful for them, I wouldn't
> object to adding a patch something like this.
>
> Cheers,
>
> 						- Ted
>
I think it's very helpful.

Thank you very much for your detailed explanation!


Cheers,
Baokun

