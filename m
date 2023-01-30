Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2577B68056B
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jan 2023 06:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjA3FJW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Jan 2023 00:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjA3FJV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Jan 2023 00:09:21 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6868123845
        for <linux-ext4@vger.kernel.org>; Sun, 29 Jan 2023 21:09:20 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30U59Dgg018644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 00:09:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1675055354; bh=to+Uah/w5VQbafkTxw3pVhbPf0AL1HRSkLjEBMsn6Uc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=X5VraL6tTWR97xIZ9xunLpMl3lHlKCSmL589BLkNDCRA+ZOYzAlaIqH00fsRU67cz
         tamafMPsQuXsOAbRZy+jrSz3uRqsQKFQYZ7upmMAgdEblfnpLdFhn64C55iUlkvYuh
         e4strsYcjmG2FVJB9uwyLoJWzUYVMBpqvffwqPpfD4l1701tkbXUpn5iatjqI0kRTF
         uaUCM30xQKst5i8J5Kd9mw1Ea1cnLo6lgn5oULffSmCQEdhAy7WrxTHymy4NBKIvFH
         7T6TUjGTsK2uuiofj4RWzis/bDYRQECfykkI1eZxUsb5mOG+vePGwksqnbMtdDKrWm
         atkkEJRw1nRIQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 142D315C3589; Mon, 30 Jan 2023 00:09:13 -0500 (EST)
Date:   Mon, 30 Jan 2023 00:09:13 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 4/4] lib/uuid: remove unneeded Windows UUID workaround
Message-ID: <Y9dQ+S7ZJ6mxiUdO@mit.edu>
References: <20230128224651.59593-1-ebiggers@kernel.org>
 <20230128224651.59593-5-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128224651.59593-5-ebiggers@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Jan 28, 2023 at 02:46:51PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Some .c files in lib/uuid/ contain the following:
> 
> 	#ifdef _WIN32
> 	#define _WIN32_WINNT 0x0500
> 	#include <windows.h>
> 	#define UUID MYUUID
> 	#endif
> 
> This seems to have been intended to allow the use of a local "UUID" type
> without colliding with "UUID" in the Windows API.  However, this is
> unnecessary because there's no local "UUID" type -- there's only uuid_t.
> 
> None of these .c files need the include of windows.h, either.
> 
> Finally, the unconditional definition of _WIN32_WINNT causes a compiler
> warning when the user defines _WIN32_WINNT themself.
> 
> Since this code is unnecessary and is causing problems, just remove it.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied to the maint branch.

					- Ted
