Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8724328FD
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Oct 2021 23:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhJRVXC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Oct 2021 17:23:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59264 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJRVXB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Oct 2021 17:23:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1DAE921966;
        Mon, 18 Oct 2021 21:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634592049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tFE0kmdW7ZCxv6Wv3/Y0uIYIuMbSt8ZTNysIys5gONI=;
        b=SBxnYceU79mGNIe+JqiJF9lLO+lHEbklJ9sNDAYoWqr55tlEwpdlmXyKfFr0fvZP2F6a4X
        LAjhHglt+iDDp5WKAp9Pm78VV6wNLAH+P3gSmMZczyW8QSxxWQETdXd7TKkMEEWwcmtj95
        QEHqpCiNicQxaJawEQTqpK5rIQo0kCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634592049;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tFE0kmdW7ZCxv6Wv3/Y0uIYIuMbSt8ZTNysIys5gONI=;
        b=GgwxqWs0o9qoeIm/sZXAMcfy54gwh9oEqPgMLEI2yNLVIy213C1jNOoOtBZChuEpWvdK3t
        DDvGxah686KralDw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id E5A56A3B84;
        Mon, 18 Oct 2021 21:20:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8F24C1E0BE5; Mon, 18 Oct 2021 23:20:45 +0200 (CEST)
Date:   Mon, 18 Oct 2021 23:20:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     xueqingwen <xueqingwen@baidu.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhaojie <zhaojie17@baidu.com>, jimyan <jimyan@baidu.com>
Subject: Re: [PATCH] ext4: start the handle later in ext4_writepages() to
 avoid unnecessary wait
Message-ID: <20211018212045.GA24360@quack2.suse.cz>
References: <20210923121204.5772-1-xueqingwen@baidu.com>
 <YWeWiUQ1bSujcCzc@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWeWiUQ1bSujcCzc@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 13-10-21 22:31:37, Theodore Ts'o wrote:
> On Thu, Sep 23, 2021 at 08:12:04PM +0800, xueqingwen wrote:
> >   ....
> > Therefore, the handle was delayed to start until finding the pages that
> > need mapping in ext4_writepages(). With this patch, the above problem did
> > not recur. We had looked this patch over pretty carefully, but another pair
> > of eyes would be appreciated. Please help to review whether there are
> > defects and whether it can be merged to upstream.
> 
> Hi,
> 
> I've tried tests against this patch, and it's causing a large number
> of hangs.  For most of the hangs, it's while running generic/269,
> although there were a few other tests which would cause the kernel to
> hang.
> 
> I don't have time to try to figure out why your patch might be
> failing, at least not this week.  So if you could take a look at at
> the test artifiacts in this xz compressed tarfile, I'd appreciate it.
> The "report" file contains a summary report, and the *.serial files
> contain the output from the serial console of the VM's which were
> hanging with your patch applied.  Perhaps you can determine what needs
> to be fixed to prevent the kernel hangs?

Well, I guess the problem is that proper lock ordering is transaction start
-> page lock and this patch inverts it so it creates all sorts of deadlock
possibilities. Lockdep will not catch this problem because page lock is not
tracked by it.

I do understand the problem description but this just isn't a viable
solution to it. There are some possible solutions like locking the first
page outside of transaction, then unlocking it, starting a transaction and
then only trylocking pages in mpage_prepare_extent_to_map() but it tends to
result in pretty ugly code. Also we'd need to make sure we don't call
submit_bio() when having transaction started (as that is where throttling
happens) - any such place may cause described latency problems. It's going
to be rather difficult to find and address all such places.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
