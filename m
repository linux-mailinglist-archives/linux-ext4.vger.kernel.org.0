Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D34C58FE66
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Aug 2022 16:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbiHKOeZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Aug 2022 10:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbiHKOeK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Aug 2022 10:34:10 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCD38F96A
        for <linux-ext4@vger.kernel.org>; Thu, 11 Aug 2022 07:33:31 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-49-209-117.bstnma.fios.verizon.net [108.49.209.117])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 27BEWd1Y008258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 10:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1660228361; bh=Tdv8Y5kYoPDyhga67v4wIkj2O9MAYveNjoQ8gJ4CrYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KZoraGAQ0WWADvILsO+yksc1GeZ+Jl5XNrIAn1pvx1CH7pzdVi/V3YhZDa3fSW1qi
         k4IZmQuHaUwNFbJjpNZCJmRftHr2HIYcYDUmuSlbtHczaaUR5t2K+1YcfCcgMlJWUk
         ECqmB1TW809fq/rgvzf+h1C3k10UkuxZ+kyvH4+P57A24a0xelbr4wrKK98B5G80Nu
         Qi8gBeLdzXFwq7HFIRqMBY+SrEVXRaN4c3TqqUpN9/z6QBBvJxe64soiSp44SLIcNM
         yqNnVxhcJLnZxUKNSSTLI+dHcU42lmVRshbtek3wEU2tvnrSkuFDfRl41wz8hzkGCZ
         s6ugmuT/b7AFg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8395E15C41BD; Thu, 11 Aug 2022 10:32:38 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     krisman@collabora.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-ext4.vger.kernel.org@urbanec.net
Subject: Re: [PATCH] e2fsck: Always probe filesystem blocksize with simple io_manager
Date:   Thu, 11 Aug 2022 10:32:35 -0400
Message-Id: <166022767028.3024810.4081400263352590556.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <87pml4lt5v.fsf_-_@collabora.com>
References: <493bbaea-b0d3-4f8e-20fb-5fb330a128a3@urbanec.net> <YlniK5dd1wV2bCXi@mit.edu> <87pml4lt5v.fsf_-_@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 25 Apr 2022 18:01:00 -0400, Gabriel Krisman Bertazi wrote:
>Combining superblock (-b) with undo file (-z) fails iff the block size
>is not specified (-B) and is different from the first blocksize probed
>in try_open_fs (1k).  The reason is as follows:
>
>try_open_fs() will probe different blocksizes if none is provided on
>the command line. It is done by opening and closing the filesystem
>until it finds a blocksize that makes sense. This is fine for all
>io_managers, but undo_io creates the undo file with that blocksize
>during ext2fs_open.  Once try_open_fs realizes it had the wrong
>blocksize and retries with a different blocksize, undo_io will read
>the previously created file and think it's corrupt for this
>filesystem.

Applied, thanks!

[1/1] e2fsck: Always probe filesystem blocksize with simple io_manager
      commit: 0ae0e93624a933a1c6ea4e4680ff5d609f267a43

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
