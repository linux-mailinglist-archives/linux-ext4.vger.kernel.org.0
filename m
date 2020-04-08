Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACD881A1E0A
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 11:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgDHJbx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 05:31:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:48252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgDHJbx (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 8 Apr 2020 05:31:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5F3CCAF0D;
        Wed,  8 Apr 2020 09:31:51 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 356481E1239; Wed,  8 Apr 2020 11:31:51 +0200 (CEST)
Date:   Wed, 8 Apr 2020 11:31:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ext4: reimplement ext4_empty_dir() using
 is_dirent_block_empty
Message-ID: <20200408093151.GA30172@quack2.suse.cz>
References: <20200407064616.221459-1-harshadshirwadkar@gmail.com>
 <20200407064616.221459-3-harshadshirwadkar@gmail.com>
 <BFC2DE9E-82FA-4F76-9BD2-B505324F3557@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BFC2DE9E-82FA-4F76-9BD2-B505324F3557@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 07-04-20 11:21:01, Andreas Dilger wrote:
> While looking at this code, I noticed that ext4_empty_dir() considers a
> directory without a "." or ".." entry to be empty.  I see this was changed
> in 64d4ce8923 ("ext4: fix ext4_empty_dir() for directories with holes").
> I can understand that we want to not die on corrupted leaf blocks, but it
> isn't clear to me that it is a good idea to allow deleting an entire
> directory tree if the first block has an error (missing "." or ".." as the
> first and second entries) but is otherwise valid.  There were definitely
> bugs in the past that made "." or ".." not be the first and second entries.

That's a good question. I'd just say that ext4_empty_dir() generally
returns true when there's some problem with the directory. In commit
64d4ce8923 I just followed that convention. This behavior of ext4_empty_dir()
(and empty_dir() before in ext3) dates back at least to the beginning of
git history... I guess we could err on the safer side and disallow
directory deletion if there is any problem with it but I guess there was
some motivation for this behavior in the past? Maybe somebody remembers?

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
