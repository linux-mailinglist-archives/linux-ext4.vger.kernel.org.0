Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D129100A1D
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2019 18:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfKRRUO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Nov 2019 12:20:14 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37626 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726317AbfKRRUO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Nov 2019 12:20:14 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-103.corp.google.com [104.133.8.103] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xAIHK79m003181
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Nov 2019 12:20:09 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AF2A44202FD; Mon, 18 Nov 2019 12:20:06 -0500 (EST)
Date:   Mon, 18 Nov 2019 12:20:06 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [e2fsprogs PATCH 0/6] chattr.1 updates
Message-ID: <20191118172006.GD27585@mit.edu>
References: <20191118014852.390686-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118014852.390686-1-ebiggers@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Nov 17, 2019 at 05:48:46PM -0800, Eric Biggers wrote:
> This series updates the chattr(1) man page to document the verity file
> attribute ('V'), improve the documentation for the encryption file
> attribute ('E'), and make a few other cleanups.
> 
> Eric Biggers (6):
>   chattr.1: document the verity attribute
>   chattr.1: adjust documentation for encryption attribute
>   chattr.1: add casefold attribute to mode string
>   chattr.1: fix some grammatical errors
>   chattr.1: clarify that ext4 doesn't support tail-merging either
>   chattr.1: say "cleared" instead of "reset"
> 
>  misc/chattr.1.in | 40 +++++++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 15 deletions(-)

Thanks for the updates to the chattr man page.  I've applied it to the
maint branch.

				- Ted
