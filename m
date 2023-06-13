Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B2D72D978
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jun 2023 07:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjFMFrG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jun 2023 01:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239066AbjFMFrG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Jun 2023 01:47:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA719C
        for <linux-ext4@vger.kernel.org>; Mon, 12 Jun 2023 22:47:03 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 854E168BEB; Tue, 13 Jun 2023 07:47:00 +0200 (CEST)
Date:   Tue, 13 Jun 2023 07:47:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, tytso@mit.edu,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: set FMODE_CAN_ODIRECT instead of a dummy
 direct_IO method
Message-ID: <20230613054700.GA14648@lst.de>
References: <20230612053731.585947-1-hch@lst.de> <87wn0853pw.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wn0853pw.fsf@doe.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jun 13, 2023 at 11:00:19AM +0530, Ritesh Harjani wrote:
> why do we require .direct_IO function op for any of the dax_aops?
> IIUC, any inode if it supports DAX i.e. IS_DAX(inode), then it takes the
> separate path in file read/write iter path.
> 
> so it should never do ->direct_IO on an inode which supports DAX right?

do_dentry_open rejects opens with O_DIRECT if FMODE_CAN_ODIRECT is
not set.  So we either needs to set that manually or because there is a
->direct_IO if we want to keep supporting O_DIRECT opens for DAX
files, which we've traditionally supported.
