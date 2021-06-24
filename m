Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB8B3B305E
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jun 2021 15:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFXNrE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Jun 2021 09:47:04 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45192 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229940AbhFXNrE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Jun 2021 09:47:04 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15ODiehu015963
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 09:44:40 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id ECBB115C3CD7; Thu, 24 Jun 2021 09:44:39 -0400 (EDT)
Date:   Thu, 24 Jun 2021 09:44:39 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: fix comment for s_hash_unsigned
Message-ID: <YNSMR220s0aAlGps@mit.edu>
References: <20210527235557.2377525-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527235557.2377525-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, May 27, 2021 at 04:55:57PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Fix the comment for s_hash_unsigned to not be the opposite of what it
> actually is.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied, thanks.

				- Ted
