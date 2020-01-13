Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7172413995F
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2020 19:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgAMSzD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Jan 2020 13:55:03 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48658 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726435AbgAMSzC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Jan 2020 13:55:02 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00DIsuku020459
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jan 2020 13:54:57 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0D4794207DF; Mon, 13 Jan 2020 13:54:56 -0500 (EST)
Date:   Mon, 13 Jan 2020 13:54:55 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: uninline ext4_inode_journal_mode()
Message-ID: <20200113185455.GD30418@mit.edu>
References: <20191209233602.117778-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209233602.117778-1-ebiggers@kernel.org>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Dec 09, 2019 at 03:36:02PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Determining an inode's journaling mode has gotten more complicated over
> time.  Move ext4_inode_journal_mode() from an inline function into
> ext4_jbd2.c to reduce the compiled code size.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

					- Ted
