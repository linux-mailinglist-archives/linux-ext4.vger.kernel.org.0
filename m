Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB23773C4D
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Aug 2023 18:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjHHQD7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Aug 2023 12:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjHHQCq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Aug 2023 12:02:46 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6DB65AD
        for <linux-ext4@vger.kernel.org>; Tue,  8 Aug 2023 08:44:48 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-112-100.bstnma.fios.verizon.net [173.48.112.100])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 378EXcUK010681
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Aug 2023 10:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1691505224; bh=POsuLKf+nXyR7IYhWeM46kPBqQcMGC9ufKCQTBFFtf0=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=cOrIQ7oNj6T1c0fsinQ9p/311Q2F4m5/0q05C1455WuPyH2K8UBnhKJSDFgrMhlQ2
         95TCUswKGgeZ93icN/qFXvZ4PFIeVLvTqCyGJSkr5/Hz0zYndnZqjL+0GCFPb23rJo
         mjok7gxFN5RVi2v0bSORo46pgcUAdq3jATQ1GBTdLppGxI2uy1+snUAiJHOa6PXRdA
         j1Bzi2Llx5MGVf77KB/v6kg5g7aPiYYs5cyk5rkLLtv475/vyR4enLzw5BWIelvh61
         K1tPTIQp1NAuPNLVO7zDo+czKmufwg3QuqGqX35UsCq0La0KCC/YHTY44JHDVK3fYl
         a89nfd/rhOeZQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id ABF4415C04F2; Tue,  8 Aug 2023 10:33:38 -0400 (EDT)
Date:   Tue, 8 Aug 2023 10:33:38 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, ocfs2-devel@lists.linux.dev,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] ext4: don't use bdev->bd_super in
 __ext4_journal_get_write_access
Message-ID: <20230808143338.GA1523259@mit.edu>
References: <20230807112625.652089-1-hch@lst.de>
 <20230807112625.652089-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807112625.652089-3-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 07, 2023 at 12:26:23PM +0100, Christoph Hellwig wrote:
> __ext4_journal_get_write_access already has a super_block available,
> and there is no need to go from that to the bdev to go back to the
> owning super_block.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Theodore Ts'o <tytso@mit.edu>
