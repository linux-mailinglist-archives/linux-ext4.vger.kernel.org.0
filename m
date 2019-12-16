Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F36DE11FCF0
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Dec 2019 03:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfLPCmH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Dec 2019 21:42:07 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46705 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726426AbfLPCmH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Dec 2019 21:42:07 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBG2fsqX002256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Dec 2019 21:41:55 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9A7CF4207DF; Sun, 15 Dec 2019 21:41:54 -0500 (EST)
Date:   Sun, 15 Dec 2019 21:41:54 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     jack@suse.cz, adilger.kernel@dilger.ca, paulmck@kernel.org,
        joel@joelfernandes.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, rcu@vger.kernel.org
Subject: Re: [PATCH V2] ext4: use rcu API in debug_print_tree
Message-ID: <20191216024154.GB11512@mit.edu>
References: <20191213113510.GG15474@quack2.suse.cz>
 <20191213153306.30744-1-tranmanphong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213153306.30744-1-tranmanphong@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 13, 2019 at 10:33:07PM +0700, Phong Tran wrote:
> struct ext4_sb_info.system_blks was marked __rcu.
> But access the pointer without using RCU lock and dereference.
> Sparse warning with __rcu notation:
> 
> block_validity.c:139:29: warning: incorrect type in argument 1 (different address spaces)
> block_validity.c:139:29:    expected struct rb_root const *
> block_validity.c:139:29:    got struct rb_root [noderef] <asn:4> *
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>

Applied, thanks.

						- Ted
