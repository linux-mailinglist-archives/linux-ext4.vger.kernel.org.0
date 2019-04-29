Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD3CBDA3C
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Apr 2019 02:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfD2Ai3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 28 Apr 2019 20:38:29 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52217 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726223AbfD2Ai3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 28 Apr 2019 20:38:29 -0400
Received: from callcc.thunk.org (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x3T0cNQd022495
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Apr 2019 20:38:25 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0840C420023; Sun, 28 Apr 2019 20:38:23 -0400 (EDT)
Date:   Sun, 28 Apr 2019 20:38:22 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] libext2fs: remove unused variable 'old_flags'
Message-ID: <20190429003822.GH3789@mit.edu>
References: <20190422211136.188952-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422211136.188952-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 22, 2019 at 02:11:36PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> In ext2fs_write_inode2(), the 'old_flags' variable is never used.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied, thanks.

					- Ted
