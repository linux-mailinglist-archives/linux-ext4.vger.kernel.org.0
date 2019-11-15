Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAEAFFDFF4
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2019 15:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfKOOXT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Nov 2019 09:23:19 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40065 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727380AbfKOOXT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Nov 2019 09:23:19 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xAFENDBm016898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 09:23:14 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 21E9C4202FD; Fri, 15 Nov 2019 09:23:13 -0500 (EST)
Date:   Fri, 15 Nov 2019 09:23:13 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] jbd2: Make jbd2_handle_buffer_credits() handle reserved
 handles
Message-ID: <20191115142313.GB23689@mit.edu>
References: <20191115102210.29445-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115102210.29445-1-jack@suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 15, 2019 at 11:22:10AM +0100, Jan Kara wrote:
> The helper jbd2_handle_buffer_credits() doesn't correctly handle reserved
> handles which can lead to crashes. Fix it getting of journal pointer to
> work for reserved handles as well.
> 
> Fixes: a9a8344ee171 ("ext4, jbd2: Provide accessor function for handle credits")
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted
