Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCAF5EF75E
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Sep 2022 16:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbiI2OVK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Sep 2022 10:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbiI2OVH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Sep 2022 10:21:07 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80205F200;
        Thu, 29 Sep 2022 07:21:03 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28TEKljw015823
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 10:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664461249; bh=3Ouo6kavYwrUtz2HGyh/EDIwQkfXK33AAc1QC2V0d5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=PJg1HXJ7EVMlAhCE4L/rFKWMedYKt7CfkrXv0cxeIOCVdSoY7oa6XkCcQsFLcJ93A
         ghadcpkf4G4BokFs7TMCelI7mBgEXBy0yi4Xd4TgsoQtzrxpj+44/z4yMW9IIaEK6c
         6jffvKJQikuEJYkw+0qreMlScCRdtTuI+qXFHBr6oRjK5laOwFWE9xyLYDi5rZoBkh
         vq/+AgdpLgHbN2kVlsHg5uInxAbeXQn8tZEKAo1uwjgXniBaTMSSJhbIOwfXWBfkPA
         Sk/Sroeg+aRc+uNy34Er0T5a2HOSiNeSO18BG9G7y+yQfJ9BvyRtD4GtcnTZoJqBvJ
         aFWcnGnocWgrA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6839815C00C9; Thu, 29 Sep 2022 10:20:47 -0400 (EDT)
Date:   Thu, 29 Sep 2022 10:20:47 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Marc =?iso-8859-1?Q?Aur=E8le?= La France <tsi@tuyoix.net>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Register ext[23] support only after successful
 ext4 registration
Message-ID: <YzWpv8ZKJ7BrOBsg@mit.edu>
References: <7ef87cdb-0d0b-2488-6f42-a670a6454630@tuyoix.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ef87cdb-0d0b-2488-6f42-a670a6454630@tuyoix.net>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 10, 2022 at 02:20:45PM -0600, Marc Aurèle La France wrote:
> Register ext4 as a "replacement" for ext2 and ext3 only after ext4 itself has
> been successfully registered.  As a side effect, this allows
> unregister_as_ext[23]() to be inlined.

The corrent ordering is deliberate; it allows file systems that have
ext2 and ext3 only file system features will be reported as using ext2
and ext3 in /proc/mounts.  This doesn't matter quite as much, but it
could potentially break userspace if a legacy file system that only
has ext2 file system features is mounted and reported as ext4.

So sorry, I can't take this change.

					- Ted
