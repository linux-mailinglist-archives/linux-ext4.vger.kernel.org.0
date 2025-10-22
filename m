Return-Path: <linux-ext4+bounces-11019-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C59C1BFB4B9
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Oct 2025 12:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ACFF19C049A
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Oct 2025 10:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136AB312810;
	Wed, 22 Oct 2025 10:04:49 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFEE287504;
	Wed, 22 Oct 2025 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127488; cv=none; b=rCCHMyyOZFl8I1JOnFXvhMxunPKd4VaXsWtmjhDd5A7UMfj4WsOYkVuM9u3hKlKxbvVsdpUsX58DebryzTdj4RHb3orc46VmUxKMghyAdKgKLP5dY6IDpk6U2Z3zxjngC+vO0Lm3yD8gD3A6nhhhn8VuM5wjr88b6g2XVPLfoc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127488; c=relaxed/simple;
	bh=KRVwGGYtJ4e3dE00cpCtGBI7L4IU+mtRzo4g6L/ZLKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJvP8Hgw99MEPwgxlApERT5UL0j+YFMGHV6bybIz41tj7AdhoES95qgAm7Inknz5fzCCib7/ohcUkkJBKpQWVhLG6HmY9tJkrQDKz/rhA+QCY+VHz4rQnMD1mBf/0cu/yHHPclenDbK5/z7saLMLslfWQwBDjCvMAT14xmQ5MtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 59MA4YWO067654;
	Wed, 22 Oct 2025 19:04:34 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 59MA4YPo067651
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 22 Oct 2025 19:04:34 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a6fcc693-42f0-4d70-a1af-fc1bfb328eb7@I-love.SAKURA.ne.jp>
Date: Wed, 22 Oct 2025 19:04:33 +0900
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jbd2: assign different lock_class_key for different
 filesystem
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <e42f1471-a88a-4938-8743-1d5b171c47ec@I-love.SAKURA.ne.jp>
 <fwsxrb7ugi5zeosugo6hyjdbhw36ppa5kekfi6n7we2vvi3r7m@ljrizqoagsg7>
 <93744126-237b-4e36-8a62-a33e1fb52051@I-love.SAKURA.ne.jp>
 <mjzb7q6juxndqtmoaee3con6xtma5vfzkgfcicjjmt7ltv2gtt@ps2np5r36vn3>
 <96c8fca1-7568-46c8-a5ad-af4699b95d5e@I-love.SAKURA.ne.jp>
 <doq4csrkuhpha7v5lunesdrscmqmjvt3flids3iai2gvpbhp3j@mxldi4yvvymw>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <doq4csrkuhpha7v5lunesdrscmqmjvt3flids3iai2gvpbhp3j@mxldi4yvvymw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav101.rs.sakura.ne.jp

On 2025/10/21 22:39, Jan Kara wrote:
>>> Yes, something like this. In fact, I think we could get away with just
>>> jbd2_trans_commit_key. There's definitely no need for j_revoke_lock,
>>> j_list_lock, j_history_lock, j_state_lock, j_abort_mutex keys as these are
>>> internal to jbd2. j_checkpoint_mutex and j_barrier do wrap around some
>>> filesystem code so maybe we'll need to specify keys for them but I'd start
>>> with just jbd2_trans_commit_key and wait whether syzbot manages to trigger
>>> another false positive report with that.
>>
>> I tried https://syzkaller.appspot.com/x/patch.diff?x=11b4dde2580000 .
>> But I think https://syzkaller.appspot.com/x/patch.diff?x=1644c3cd980000
>> pattern which all mutex_init_with_key() users follow seems more simpler
>> and easier to apply. What do you think?
> 
> Yes, the second version looks nicer. Thanks! BTW, did you verify that
> annotating j_barrier, j_checkpoint_mutex, and j_abort_mutex is really
> needed? Because I'd be slightly surprised if it really was...

No. https://syzkaller.appspot.com/x/patch.diff?x=13a94e7c580000 was sufficient
for this specific report. But I don't know what will happen with ocfs2 which has
so complicated locking dependency ( https://syzkaller.appspot.com/upstream/s/ocfs2
has currently 27 open "possible deadlock" reports).

Do you want me to try this minimal change in linux-next via my tree for a while?
Or do you want to just apply this minimal change first?


