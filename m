Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0EA35E920
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Apr 2021 00:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhDMWlA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Apr 2021 18:41:00 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54386 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232723AbhDMWk7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Apr 2021 18:40:59 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13DMeYXx016062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 18:40:34 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D094415C3B1E; Tue, 13 Apr 2021 18:40:33 -0400 (EDT)
Date:   Tue, 13 Apr 2021 18:40:33 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Daniel Rosenberg <drosen@google.com>, linux-ext4@vger.kernel.org
Subject: Re: [xfstests-bld PATCH] test-appliance: un-exclude encrypt+casefold
 test
Message-ID: <YHYd4Wmk0xqnuhUc@mit.edu>
References: <20210413215300.10700-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413215300.10700-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 13, 2021 at 02:53:00PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> This is needed to test the encryption and casefolding features in
> combination.

Yeah, this is has been on my radar screen, but it's been on my todo
list to submit a patch to generic/556 something like:

if [ "$FSTYP" = "ext4" -a ! -f /sys/fs/ext4/features/encrypted_casefold ]; then
   _notrun "ext4 file system does not support encrypted casefold"
fi

before removing generic/556 from the encrypt.exclude list.

I'll probably get to it by this weekend, unless someone beats me to
it.

Cheers,

					- Ted
					
