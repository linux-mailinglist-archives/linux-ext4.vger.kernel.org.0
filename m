Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA1DEEE006
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2019 13:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfKDMg7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Nov 2019 07:36:59 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58691 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727267AbfKDMg6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Nov 2019 07:36:58 -0500
Received: from callcc.thunk.org (ip-12-2-52-196.nyc.us.northamericancoax.com [196.52.2.12])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xA4CarIK026247
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Nov 2019 07:36:54 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id F2955420311; Mon,  4 Nov 2019 07:36:50 -0500 (EST)
Date:   Mon, 4 Nov 2019 07:36:50 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 15/22] jbd2: Factor out common parts of stopping and
 restarting a handle
Message-ID: <20191104123650.GB28764@mit.edu>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191003220613.10791-15-jack@suse.cz>
 <20191021174933.GH27850@mit.edu>
 <20191023161724.GE31271@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023161724.GE31271@quack2.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 23, 2019 at 06:17:24PM +0200, Jan Kara wrote:
> > What is j_state_lock protecting at this point?  There's only a 32-bit
> > read of j_commit_request at this point.
> 
> We could almost drop the lock. To be fully correct, we'd then need to use
> READ_ONCE here and WRITE_ONCE in places changing j_commit_request (reasons
> are well summarized in recent LWN series on how compiler can screw your
> unlocked reads and writes). So probably a fair cleanup but something I've
> decided to leave for later.

Fair enough; maybe leave a quick TODO comment so we remember that this
is an outstanding clean up?

						- Ted
