Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1C27BBE59
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Oct 2023 20:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbjJFSGm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Oct 2023 14:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjJFSGm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Oct 2023 14:06:42 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AE2C2
        for <linux-ext4@vger.kernel.org>; Fri,  6 Oct 2023 11:06:38 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-143.bstnma.fios.verizon.net [173.48.111.143])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 396I6XBO008024
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Oct 2023 14:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1696615594; bh=BrAE8iBAqoGudefq+CU0eHk5VRpk9NZ13gPIXXJuS4k=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=FTwIMzXtvNAATIx4GddyXuMw+I/GslLT00KfQqMafLAE+oWSWSc4WjJrYygofNPCk
         zRDL5Yil23JaPjqi6JPaNft7ZTT/ykjGx7tusyqxtS2+hxVgqRlBFUI6haK9R6zNon
         CPNQmjom0dCB1OR1KwtXyjkykl1FhskP4lBNQ8YCNbjc9XgmDwMdM9v3GUX+KX34hN
         IQft0HHiuh13jZBRzQNvqObcR1ezrGMf630Gp+XcC2hEMfh8oWebCUn3L97LjA3Nfw
         qPAahA4C3pYbrOCn7cNDHSPo8DXxSZW/Oka449AoGvZwzvX7SgCIuVD9456x3GILne
         kuq3YRDvsx4xw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 196A715C0250; Fri,  6 Oct 2023 14:06:33 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Brian Foster <bfoster@redhat.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] ext4: fix racy may inline data check in dio write
Date:   Fri,  6 Oct 2023 14:06:16 -0400
Message-Id: <169661554699.173366.13182900312377445374.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20231002185020.531537-1-bfoster@redhat.com>
References: <20231002185020.531537-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Mon, 02 Oct 2023 14:50:20 -0400, Brian Foster wrote:
> syzbot reports that the following warning from ext4_iomap_begin()
> triggers as of the commit referenced below:
> 
>         if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
>                 return -ERANGE;
> 
> This occurs during a dio write, which is never expected to encounter
> an inode with inline data. To enforce this behavior,
> ext4_dio_write_iter() checks the current inline state of the inode
> and clears the MAY_INLINE_DATA state flag to either fall back to
> buffered writes, or enforce that any other writers in progress on
> the inode are not allowed to create inline data.
> 
> [...]

Applied, thanks!

[1/1] ext4: fix racy may inline data check in dio write
      commit: a37d4c46392e207518deb6533768986634b193c0

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
