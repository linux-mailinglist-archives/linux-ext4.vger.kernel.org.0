Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8281588EB0
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Aug 2022 16:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbiHCObW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Aug 2022 10:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHCObW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Aug 2022 10:31:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6EC7E1181C
        for <linux-ext4@vger.kernel.org>; Wed,  3 Aug 2022 07:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659537080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uhfFd+3mPpqUapbaI0QRaYeC+PiyY6e22+W6me0qc8A=;
        b=M6yRgIXMBdJlSpeB1pw55reSo1qyNu71h1ySr0pmkx2KhdtFzTzNCXdZOQM2tGvYiTnVbL
        rHGAJScWg6jEXuGgdp3vvy8YUbsaA3i56NPfEozhhJiBocVdqmLCAOdrF5HQextJzkMxVZ
        lc1YbBv6Ld7cjaNKTx7bWdZxtdxfXPg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-A77mATKQPBK1NM42cudzmQ-1; Wed, 03 Aug 2022 10:31:17 -0400
X-MC-Unique: A77mATKQPBK1NM42cudzmQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF0D8811E84;
        Wed,  3 Aug 2022 14:31:16 +0000 (UTC)
Received: from fedora (unknown [10.40.194.92])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3080E2166B26;
        Wed,  3 Aug 2022 14:31:16 +0000 (UTC)
Date:   Wed, 3 Aug 2022 16:31:13 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Daniel Ng <danielng@google.com>
Cc:     linux-ext4@vger.kernel.org,
        Sarthak Kukreti <sarthakkukreti@google.com>
Subject: Re: [BUG] fsck unable to resolve filenames that include '='
Message-ID: <20220803143113.frmayykhlhvcqkxg@fedora>
References: <CANFuW3eGgyeWba-2GjDtdhYvX2fV7-dcrHn-4O8QAeHDERAbqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANFuW3eGgyeWba-2GjDtdhYvX2fV7-dcrHn-4O8QAeHDERAbqw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 02, 2022 at 06:21:56PM +1000, Daniel Ng wrote:
> Hi,
> 
> I've run into an issue when trying to use fsck with an ext4 image when
> it has '=' in its name.
> 
> Repro steps:
> 1. fallocate -l 1G test=.img
> 2. mkfs.ext4 test=.img
> 3. fsck test=.img
> 
> Response:
> 'fsck.ext4: Unable to resolve '<path>/test=.img'
> 
> Expected:
> fsck to do it's thing.
> 
> Observations:
> Originally I wasn't sure what the source was, I thought that maybe
> mkfs wasn't creating the image appropriately.
> However, I've tried:
> - renaming the image
> - creating a hard-link to the image
> 
> Running fsck on either the renamed image, or the hard-link, works as expected.
> 
> Kernel version: Linux version 4.19.251-13516-ga0bcf8d80077
> Environment: Running on a Chromebook
> 
> Kind regards,
> Daniel

Hi Daniel,

yeah, that's a good catch. The problem is that various e2fsprogs tools
(at least tune2fs and e2fsck) are using blkid_get_devname() to get the
device name without ever checking if we already got the actual existing
device name.

The reason to call blkid_get_devname() at all is to get device in the
form of NAME=value (like for example UUID=uuid, or LABEL=volume-label).
However if we blindly pass in the device (or in this case regular file)
name with an equal sign in it, the blkid_get_devname just returns whatever
it can find by that tag. Which is likely nothing.

Unless of course, you're trying to use e2fsck, or tune2fs on a file with
an actual filename LABEL=volume-label and you have actual file system
with 'volume-label' LABEL ;) That's a problematic behavior and depending
on how we go about fixing it it could be potentialy exploitable...

Maybe something like this:

	1. look for the actual block device first
	2. if none is found call blkid_get_devname()
	3. if that didn't return anything maybe see if have a regular
	   file and work with that
	4. if we still get nothing, then we're "Unable to resolve..."

Thoughts?

-Lukas

