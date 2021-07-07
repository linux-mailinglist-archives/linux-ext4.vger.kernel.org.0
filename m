Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160D83BE14B
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Jul 2021 05:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhGGDQS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jul 2021 23:16:18 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49053 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229989AbhGGDQR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jul 2021 23:16:17 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1673DYqi004988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Jul 2021 23:13:34 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1D10615C3CC6; Tue,  6 Jul 2021 23:13:34 -0400 (EDT)
Date:   Tue, 6 Jul 2021 23:13:34 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 5/6] Fix -Wunused-variable warnings
Message-ID: <YOUb3qK6nVhpqPVq@mit.edu>
References: <20210616045334.1655288-1-ebiggers@kernel.org>
 <20210616045334.1655288-6-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616045334.1655288-6-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jun 15, 2021 at 09:53:33PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Fix all warnings about unused variables that were introduced since
> e2fsprogs v1.45.4.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Fixed, although I had to drop a hunk which was already fixed by the commit:

1e0c8ca7  e2fsck: fix portability problems caused by unaligned accesses

	  	      		  	   	     - Ted
