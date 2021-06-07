Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B7439E118
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Jun 2021 17:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhFGPrk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Jun 2021 11:47:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38952 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhFGPrj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Jun 2021 11:47:39 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CDBAF21A8A;
        Mon,  7 Jun 2021 15:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623080747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kTZ19QygUjzcyRhJnuoAa19uWrcYYUjZeVEx+bz1/SA=;
        b=M41HLKMhZmTqquZ7q4wn2MDBGke0OQIHmHdHY30x+SXuozn1BKXJC0LDja9nVTKyq3LiSp
        tiOmspPITRn1GEKX8ItNamsqVVA8caiILrtREy8TNB2lC9fgTEyFOCuyLzk8SIHZ5Rzgid
        /+Knc4cDcXTWluTEZvwiNurMSuNMKO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623080747;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kTZ19QygUjzcyRhJnuoAa19uWrcYYUjZeVEx+bz1/SA=;
        b=C+lwuUenKm0nBvEpxaLzqwQaADRSH3byvsEBpLGkMVMUCEgFxAHuWEqHfbtFhbnfDV8Mid
        BLG15jIoqXdiUAAQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 4B319A3B85;
        Mon,  7 Jun 2021 15:45:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0FD561F2CA8; Mon,  7 Jun 2021 17:45:47 +0200 (CEST)
Date:   Mon, 7 Jun 2021 17:45:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [RFC PATCH v3 5/8] jbd2,ext4: add a shrinker to release
 checkpointed buffers
Message-ID: <20210607154547.GA29326@quack2.suse.cz>
References: <20210527135641.420514-1-yi.zhang@huawei.com>
 <20210527135641.420514-6-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527135641.420514-6-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 27-05-21 21:56:38, Zhang Yi wrote:
> Current metadata buffer release logic in bdev_try_to_free_page() have
> a lot of use-after-free issues when umount filesystem concurrently, and
> it is difficult to fix directly because ext4 is the only user of
> s_op->bdev_try_to_free_page callback and we may have to add more special
> refcount or lock that is only used by ext4 into the common vfs layer,
> which is unacceptable.
> 
> One better solution is remove the bdev_try_to_free_page callback, but
> the real problem is we cannot easily release journal_head on the
> checkpointed buffer, so try_to_free_buffers() cannot release buffers and
> page under memory pressure, which is more likely to trigger
> out-of-memory. So we cannot remove the callback directly before we find
> another way to release journal_head.
> 
> This patch introduce a shrinker to free journal_head on the checkpointed
> transaction. After the journal_head got freed, try_to_free_buffers()
> could free buffer properly.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Suggested-by: Jan Kara <jack@suse.cz>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
