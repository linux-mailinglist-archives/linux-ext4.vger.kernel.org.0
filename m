Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758A8672AD7
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jan 2023 22:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjARVtk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Jan 2023 16:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjARVtj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Jan 2023 16:49:39 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EECA53B37
        for <linux-ext4@vger.kernel.org>; Wed, 18 Jan 2023 13:49:38 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30ILnPT4002843
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 16:49:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1674078567; bh=Mjx6pDHd5qfhs4XFRA1yqfjmebakmAVI9CSix2MnUG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=AaAHebwZ6mU1JuiJGvBDQJwK49m0DIe2+0tZNWCkRE84vmvlDzOzRL4DGSJcPV/BE
         XATHRxbOeLIdIx0Yew85fB+S703bMZdStM7E4QON6xwYW0l0pJEqTR114mkID8aA72
         NRz8z+hzJbSaeSuIBTeaeAmU6YHBdGh6T2hPWVmUUDA0SSwWnb3zwnNTTdsEAxfDJ2
         aIO9ejFrX5mlWI6/3eAwW5Es5dDHZZDa9k4RTxT733f/kqcl0tln1gYtv/Bi+QaUSA
         Y4I1grZ+7uZqehcq17TeLw5xAy2OJObS79cnfD/2+v3ZHy+EX1DXcUxFl0sdIv1RrR
         h2pOBq0xcAJlw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A7B7615C469B; Wed, 18 Jan 2023 16:49:25 -0500 (EST)
Date:   Wed, 18 Jan 2023 16:49:25 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Eric Whitney <enwlinux@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: Detecting default signedness of char in ext4 (despite
 -funsigned-char)
Message-ID: <Y8hpZRmHJwdutRr2@mit.edu>
References: <Y8bpkm3jA3bDm3eL@debian-BULLSEYE-live-builder-AMD64>
 <7DE6598D-B60D-466F-8771-5FEC0FDEC57F@dilger.ca>
 <Y8dtze3ZLGaUi8pi@sol.localdomain>
 <CAHk-=whUNjwqZXa-MH9KMmc_CpQpoFKFjAB9ZKHuu=TbsouT4A@mail.gmail.com>
 <Y8eAJIKikCTJrlcr@sol.localdomain>
 <Y8hUCIVImjqCmEWv@mit.edu>
 <CAHk-=wiGdxWtHRZftcqyPf8WbenyjniesKyZ=o73UyxfK9BL-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiGdxWtHRZftcqyPf8WbenyjniesKyZ=o73UyxfK9BL-A@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 18, 2023 at 03:14:04PM -0600, Linus Torvalds wrote:
> You're missing the fact that 'char' gets expanded to 'int', and in the
> process but #7 gets copied to bits 8-31 if it is signed.
> 
> Then the xor and the later shifting will move those bits around..

Doh!  One of those C pitfalls that I don't know how I mad missed.

I agree with your analysis that in actual practice, almost no one
actually uses non-ASCII characters for xattr names.  (Filenames, yes,
but in general xattr names are set by programs, not by users.)  So
besides xfstests generic/454, how likely is it that people would be
using things like Octopus emoji's or Unicode characters such as <GREEK
UPSILON WITH ACUTE AND HOOK SYMBOL>?  Very unlikely, I'd argue.  I
might be a bit more worried about userspace applications written for,
say, Red Flag Linux in China using chinese characters in xattrs, but
I'd argue even there it's much more likely that this would be in the
xattr values as opposed to the name.

In terms of what should we do for next steps, if we only pick signed,
then it's possible if there are some edge case users who actually did
use non-ASCII characters in the xattr name on PowerPC, ARM, or S/390,
they would be broken.  That's simpler, and if we think there are
darned few of them, I guess we could do that.

That being said, it's not that much more work to use a flag in the
superblock to indicate whether or not we should be explicitly casting
*name to either a signed or unsigned char, and then setting that flag
automagically to avoid problems on people who started the file system
on say, x86 before the signed to unsigned char transition, and who
started natively on a PowerPC, ARM, or S/390.

The one bit which makes this a bit more complex is either way, we need
to change both the kernel and e2fsprogs, which is why if we do the
signed/unsigned xattr hash flag, it's important to set the flag value
to be whatever the "default" signeded would be on that architecture
pre 6.2-rc1.

						- Ted
