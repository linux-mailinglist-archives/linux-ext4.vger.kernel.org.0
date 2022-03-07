Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428184D0479
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Mar 2022 17:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241199AbiCGQtP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Mar 2022 11:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237206AbiCGQtN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Mar 2022 11:49:13 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3DD22523;
        Mon,  7 Mar 2022 08:48:19 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 27E0868AFE; Mon,  7 Mar 2022 17:48:15 +0100 (CET)
Date:   Mon, 7 Mar 2022 17:48:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-raid@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Song Liu <song@kernel.org>
Subject: Re: remove bio_devname
Message-ID: <20220307164814.GA12591@lst.de>
References: <20220304180105.409765-1-hch@lst.de> <164666057398.15541.7415780807920631127.b4-ty@kernel.dk> <YiY2wUVIz3NXIjlc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiY2wUVIz3NXIjlc@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 07, 2022 at 11:45:53AM -0500, Mike Snitzer wrote:
> Should those go through block too? Or is there no plan to remove
> bdevname()?

My preference would be:  do the full bio_devname removal through Jens'
tree and you keep the bvdevname removal.  I hope bdevname will go away
as well, but certainly not in this merge window.
