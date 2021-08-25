Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35903F72F5
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Aug 2021 12:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbhHYK0G (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Aug 2021 06:26:06 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56854 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237307AbhHYK0F (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Aug 2021 06:26:05 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 86D8322155;
        Wed, 25 Aug 2021 10:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629887118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tpbraxJcDvR89nhpo0egFYJLMNkYBNia0Bq757dOmAE=;
        b=jurdnFDjJG8PjGMX///YdyR5RNSNK2IpFRc6Kil8YwGsqC5MYAdnyrb+nsMhwcJaPHSpOB
        0EfG2gNEnqHL37GJdqdbaTexE60yuSmOC/IcYZjQN6jJpIFS8OizpQr+NEQa6DJvcegjMk
        Jq5Mh6uzs7Tya+yj72R+TdFupeGFsPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629887118;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tpbraxJcDvR89nhpo0egFYJLMNkYBNia0Bq757dOmAE=;
        b=FIRZS7k6/JZKo0cUAyNT7DkimQpEa5YYub+HXeaiomONDgluZtNIaQWnWXmS0NjgT2jjGI
        YoRDcDvEQIhbMfAg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 73969A3B95;
        Wed, 25 Aug 2021 10:25:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 126321F2BA4; Wed, 25 Aug 2021 12:25:18 +0200 (CEST)
Date:   Wed, 25 Aug 2021 12:25:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     yangerkun <yangerkun@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, "Theodore Y . Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [QUESTION] question for commit 2d01ddc86606 ("ext4: save error
 info to sb through journal if available")
Message-ID: <20210825102518.GA14620@quack2.suse.cz>
References: <05ff3a17-6559-9317-a382-f0a02fa59926@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05ff3a17-6559-9317-a382-f0a02fa59926@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Hello Kun!

On Wed 25-08-21 10:13:03, yangerkun wrote:
> There is a question about 2d01ddc86606 ("ext4: save error info to sb through
> journal if available"). This commit describe that we can have checksum
> failure with follow case:
> 
> 1. ext4_handle_error will call ext4_commit_super which write directly to the
> superblock
> 2. At the same time, jounalled update of the superblock is ongoing
> 
> However, after commit 05c2c00f3769 ("ext4: protect superblock modifications
> with a buffer lock"), all the update for superblock and the csum will be
> protected with buffer lock. It seems we won't get a csum error after that
> commit and the journal logic in flush_stashed_error_work seems useless.
> 
> Maybe there is something missing... Can you help to explain more for that...

You are correct that after commit 05c2c00f3769 the checksum will be
correct. However there are also other problems that 2d01ddc86606 addresses
and that are mentioned in the commit description like "writing inconsistent
information". The fundamental problem is that you cannot mix journalled and
non-journalled updates to any block. Because e.g. the unjournalled update
could store to disk information that was changed only as part of the
currently running transaction and if the machine crashes before the
transaction commits, we have too new information in the block and thus
inconsistent filesystem. Or in the other direction, journal replay can
overwrite unjournalled modifications to the superblock if we crash at the
right moment.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
