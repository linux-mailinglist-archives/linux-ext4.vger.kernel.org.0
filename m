Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF21EE08C
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2019 13:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfKDM7R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Nov 2019 07:59:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:38986 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727236AbfKDM7R (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 4 Nov 2019 07:59:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7E060B245;
        Mon,  4 Nov 2019 12:59:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4533C1E43DA; Mon,  4 Nov 2019 13:59:15 +0100 (CET)
Date:   Mon, 4 Nov 2019 13:59:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 15/22] jbd2: Factor out common parts of stopping and
 restarting a handle
Message-ID: <20191104125915.GF22379@quack2.suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191003220613.10791-15-jack@suse.cz>
 <20191021174933.GH27850@mit.edu>
 <20191023161724.GE31271@quack2.suse.cz>
 <20191104123650.GB28764@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104123650.GB28764@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 04-11-19 07:36:50, Theodore Y. Ts'o wrote:
> On Wed, Oct 23, 2019 at 06:17:24PM +0200, Jan Kara wrote:
> > > What is j_state_lock protecting at this point?  There's only a 32-bit
> > > read of j_commit_request at this point.
> > 
> > We could almost drop the lock. To be fully correct, we'd then need to use
> > READ_ONCE here and WRITE_ONCE in places changing j_commit_request (reasons
> > are well summarized in recent LWN series on how compiler can screw your
> > unlocked reads and writes). So probably a fair cleanup but something I've
> > decided to leave for later.
> 
> Fair enough; maybe leave a quick TODO comment so we remember that this
> is an outstanding clean up?

Good idea. Added.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
