Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7923E04A4
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Aug 2021 17:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239290AbhHDPqj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Aug 2021 11:46:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44482 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239114AbhHDPqi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Aug 2021 11:46:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5451A2211D;
        Wed,  4 Aug 2021 15:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628091985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4tZcgzZRWzOIG+RMyQI0EAceaWq7eq5xTX/B+ijVy2A=;
        b=hNgDtMBmiKhkPQZto8WlmJMs1UU1bTnKLZT6Q916YKQUoBBFDB1/TxAr/xezXiGg+PLNhr
        4jr8hMDVuLsWEBqbifY1WC2WJji8ha/lCXkQOyLuFu+pH2Cr20b5EOrBYJuEReLGelno82
        lstn455j55mFzgddd6quhpRN06okQ1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628091985;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4tZcgzZRWzOIG+RMyQI0EAceaWq7eq5xTX/B+ijVy2A=;
        b=p6n3XarlYmLANiufR6psh+n+kv+cDGadWr5Jg7nbd41lWb5fcyOSpIY0bDtCdkxSFQBZT+
        2O9Ef2FGnfY/85AQ==
Received: from quack2.suse.cz (jack.udp.ovpn2.nue.suse.de [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 48385A3B9A;
        Wed,  4 Aug 2021 15:46:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 337AD1F2B83; Wed,  4 Aug 2021 17:46:25 +0200 (CEST)
Date:   Wed, 4 Aug 2021 17:46:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca
Subject: Re: [PATCH V3 5/5] ext4: make fallocate retry when err is ENOSPC
Message-ID: <20210804154625.GM4578@quack2.suse.cz>
References: <20210724074124.25731-1-jianchao.wan9@gmail.com>
 <20210724074124.25731-6-jianchao.wan9@gmail.com>
 <20210804153221.GK4578@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804153221.GK4578@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 04-08-21 17:32:21, Jan Kara wrote:
> On Sat 24-07-21 15:41:24, Wang Jianchao wrote:
> > From: Wang Jianchao <wangjianchao@kuaishou.com>
> > 
> > The blocks may be waiting for journal commit to be freed back to
> > mb buddy. Let fallocate wait and retry in that case.
> > 
> > Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
> 
> Did you really observe this? Because the retry is already handled in
> ext4_alloc_file_blocks() that's used by ext4_fallocate(). So no retry
> should be needed there.

Oh, I can see you've addressed these already in another reply. I'll comment
there.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
