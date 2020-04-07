Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13B8D1A0C15
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Apr 2020 12:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgDGKiT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Apr 2020 06:38:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:52668 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgDGKiS (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 7 Apr 2020 06:38:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 39551AA55;
        Tue,  7 Apr 2020 10:38:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DA2381E1233; Tue,  7 Apr 2020 12:38:15 +0200 (CEST)
Date:   Tue, 7 Apr 2020 12:38:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     "J. R. Okajima" <hooanon05g@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext2: Silence lockdep warning about reclaim under
 xattr_sem
Message-ID: <20200407103815.GD9482@quack2.suse.cz>
References: <20200225120803.7901-1-jack@suse.cz>
 <30602.1586151377@jrobl>
 <20200406102148.GC1143@quack2.suse.cz>
 <21323.1586173821@jrobl>
 <17830.1586236936@jrobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17830.1586236936@jrobl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 07-04-20 14:22:16, J. R. Okajima wrote:
> > I will post "the fix passed my local stress test" tomorrow.
> 
> I did my long stress test many times.
> And the fix passed my local stress test.

Thanks for testing! BTW, the fix went to Linus yesterday.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
