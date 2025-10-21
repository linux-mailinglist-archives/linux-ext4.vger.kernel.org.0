Return-Path: <linux-ext4+bounces-11004-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE50DBF5FE0
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Oct 2025 13:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAFE2485E82
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Oct 2025 11:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957FF2F39C7;
	Tue, 21 Oct 2025 11:17:22 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A554D2EFD9E;
	Tue, 21 Oct 2025 11:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761045442; cv=none; b=C2BdQ657KgQ6DDt7DvfFXz6Ru179nIiKUF1VW02udl5PEs4Gyb6BUvfpuw8OJ3WIDQP692chVuCjW1lHXshTCU8X6CkBPve+CM395fdwL2UUqXj27VwApaOR1UnqW/tNi1QYEujk1Ugmq02n+nfKVmPBj4Y58BlWI5NAg5Y2Kf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761045442; c=relaxed/simple;
	bh=YZ0NqfZgeyeEjqDhJi/2bApiJ5/KXZ9Dg/GSF/AGxIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o6sVWewf7yXh43xw62y9RxM500/8iQj/d4cDObkCR5OSKFi/7mHqKudkBm4JGTHcZBtJjIP2qXPIl9RFmOgTYHIyswqrdqt0H/yIvxUaJgSLmFDQSdvyP8HCPKMW5sfad3KABSGWCUVmWCkQBoRry0j6a463ebKN+mNNq2xueTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 59LBGvdw010442;
	Tue, 21 Oct 2025 20:16:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 59LBGvqm010438
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 21 Oct 2025 20:16:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <96c8fca1-7568-46c8-a5ad-af4699b95d5e@I-love.SAKURA.ne.jp>
Date: Tue, 21 Oct 2025 20:16:53 +0900
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
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <mjzb7q6juxndqtmoaee3con6xtma5vfzkgfcicjjmt7ltv2gtt@ps2np5r36vn3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav205.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/10/20 21:55, Jan Kara wrote:
> On Mon 20-10-25 20:28:54, Tetsuo Handa wrote:
>> On 2025/10/20 18:31, Jan Kara wrote:
>>> On Sun 19-10-25 19:52:43, Tetsuo Handa wrote:
>>>> syzbot is reporting possibility of deadlock due to sharing lock_class_key
>>>> for jbd2_handle across ext4 and ocfs2. But one disk partition can't have
>>>> two filesystems at the same time, and how locks in journal_t interacts
>>>> with other filesystem specific locks can vary depending on filesystems.
>>>> Therefore, lockdep should treat locks in journal_t different locks if
>>>> the filesystem which allocated the journal_t differs.
>>>
>>> Thanks for debugging this. I agree with the idea of your solution but the
>>> implementation is just ugly. Just let the filesystem pass the lockdep key
>>> into jbd2_journal_init_dev() / jbd2_journal_init_inode() and make ext4 and
>>> ocfs2 functions initializing the journal each have its own lock_class_key
>>> declared and pass it to jbd2 functions. That way changes are much simpler
>>> and also jbd2 doesn't have to be aware about which filesystems are using
>>> it.
>>
>> Well, do you mean something like below diff? If we can assume that only ext4
>> and ocfs2 are using jbd2, the diff becomes smaller...
> 
> Yes, something like this. In fact, I think we could get away with just
> jbd2_trans_commit_key. There's definitely no need for j_revoke_lock,
> j_list_lock, j_history_lock, j_state_lock, j_abort_mutex keys as these are
> internal to jbd2. j_checkpoint_mutex and j_barrier do wrap around some
> filesystem code so maybe we'll need to specify keys for them but I'd start
> with just jbd2_trans_commit_key and wait whether syzbot manages to trigger
> another false positive report with that.

I tried https://syzkaller.appspot.com/x/patch.diff?x=11b4dde2580000 .
But I think https://syzkaller.appspot.com/x/patch.diff?x=1644c3cd980000
pattern which all mutex_init_with_key() users follow seems more simpler
and easier to apply. What do you think?


