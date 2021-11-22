Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12524594A7
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Nov 2021 19:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238607AbhKVSZL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Nov 2021 13:25:11 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43014 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbhKVSZL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Nov 2021 13:25:11 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BA1C9218E1;
        Mon, 22 Nov 2021 18:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637605323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c98fpZGdGI0+ZOj58/qJeZeQJlRUaVRpLHlnxLE/4jg=;
        b=n6o+Xij9eQN5/lnRfvOlkAuNc3Ry7zqNfnE+ivf0R6aJ2hgpU7kdDin4yuEhpHcsUv9nVj
        xj9d3vyvsjI/2rsnCDXUlnOxMCKv6C3nf4fZlUF2axVoHXTPQJ8EHmHr9HCSCIln3ymwlv
        HVt6I7j6EHzczXMQl/7IuJPmlTLZ67Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637605323;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c98fpZGdGI0+ZOj58/qJeZeQJlRUaVRpLHlnxLE/4jg=;
        b=EzDsjigdjabVLoLgMbsPiExi1SZ12ft2deZ0BZQGfgGPC7Ee+CQvx0/hg8LWTvpHzgIrrR
        9jDDRDv8VoffkNDg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id A0CDBA3B81;
        Mon, 22 Nov 2021 18:22:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4D9991E3C6D; Mon, 22 Nov 2021 19:22:03 +0100 (CET)
Date:   Mon, 22 Nov 2021 19:22:03 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next] jbd2: discard last transaction when commit block
 checksum broken in v2v3
Message-ID: <20211122182203.GC32119@quack2.suse.cz>
References: <20210929035528.1990993-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929035528.1990993-1-yebin10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 29-09-21 11:55:28, Ye Bin wrote:
> Now, we meet an issue that commit block has broken checksum when cold reboot
> device, that lead to mount failed.
> The reason maybe only some sector store on disk, and then device power off.
> But we calculate checksum with whole logic block.The data stored on disk can
> only ensure the atomicity of sector level.
> Actually, we already replay previous transactions. We can just discard last
> transaction. As now, descriptor/revocation/commit/superblock has it's own
> checksum.
> 
> Fixes:80b3767fbe15("jbd2: don't wipe the journal on a failed journal checksum")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Thanks for the patch. It seems to have fallen through the cracks. Sorry for
that.

> ---
>  fs/jbd2/journal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 35302bc192eb..a3dd7b757b3d 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2080,7 +2080,7 @@ int jbd2_journal_load(journal_t *journal)
>  	if (jbd2_journal_recover(journal))
>  		goto recovery_error;
>  
> -	if (journal->j_failed_commit) {
> +	if (journal->j_failed_commit && !jbd2_journal_has_csum_v2or3(journal)) {

I guess this decision somewhat questionable. If the failed commit was
indeed the last one, I guess loosing the last transaction as you suggest is
a sensible thing to do. However if the checksum failed somewhere in the
middle of the journal because of a bitflip or something like that, we
probably don't want to loose that many transactions and rather want to do
fsck and try to recover as much data as possible... What do others think?

								Honza

>  		printk(KERN_ERR "JBD2: journal transaction %u on %s "
>  		       "is corrupt.\n", journal->j_failed_commit,
>  		       journal->j_devname);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
