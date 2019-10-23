Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC5DE1C9C
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Oct 2019 15:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391997AbfJWNac (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Oct 2019 09:30:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:43130 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389928AbfJWNac (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 23 Oct 2019 09:30:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 16D38B8D6;
        Wed, 23 Oct 2019 13:30:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F31A01E4A89; Wed, 23 Oct 2019 15:30:29 +0200 (CEST)
Date:   Wed, 23 Oct 2019 15:30:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 20/22] jbd2: Make credit checking more strict
Message-ID: <20191023133029.GC31271@quack2.suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191003220613.10791-20-jack@suse.cz>
 <20191021222959.GE24015@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021222959.GE24015@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 21-10-19 18:29:59, Theodore Y. Ts'o wrote:
> On Fri, Oct 04, 2019 at 12:06:06AM +0200, Jan Kara wrote:
> > Make checking of available credits in jbd2_journal_dirty_metadata() more
> > strict. There should be always enough credits in the handle to write all
> > potential revoke descriptors. Also we warn in case there are not enough
> > credits since this is a bug in the filesystem.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> This is fine, but I wonder if we should also be returning an error in
> jbd2_journal_revoke() --- of course, one problem is ext4_forget() is
> getting called from ext4_free_blocks(), which currently doesn't return
> an error.  But we can capture the error return in __ext4_forget(), and
> at that point we can give a much more useful error message, since we
> can print the function caller and line number.

Yeah, that's a good point. I'll add a sanity check to jbd2_journal_revoke()
and then generate some error message in ext4.

> Feel free to add:
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>

Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
