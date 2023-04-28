Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E5D6F1265
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Apr 2023 09:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjD1Hcj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Apr 2023 03:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjD1Hci (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Apr 2023 03:32:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD29F26A1;
        Fri, 28 Apr 2023 00:32:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 569B564162;
        Fri, 28 Apr 2023 07:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFBCC433D2;
        Fri, 28 Apr 2023 07:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682667156;
        bh=j2Oz0LSVfsAP5bNfRWQOmIIg4LOxtGTZ5TSIynmgi34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uh1Oj0hg00DoxUc7222YTspOYbWMnLj/7cPfbUQ9X7TBqM4VY8K2eTUDoN2Q6XQ0N
         VhPMj4t/zEsPKSgFT7FgQAOa+37i/szEiI2D0xABCMsZmdDsEqZfnAKlHzUnnnFAKL
         //AcIlKydjUclNNNQPdLX2V0xe/1LodbCw9bwD1w=
Date:   Fri, 28 Apr 2023 09:32:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jan Kara <jack@suse.cz>
Cc:     stable@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: Pick commit 2729cfdcfa ("ext4: use ext4_journal_start/stop for
 fast commit transactions")
Message-ID: <2023042804-feed-radiantly-2a07@gregkh>
References: <20230427162459.qb3tnh3be6ofibzz@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427162459.qb3tnh3be6ofibzz@quack3>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 27, 2023 at 06:24:59PM +0200, Jan Kara wrote:
> Hello,
> 
> recently I've debugged a deadlock issue in ext4 fast commit feature in our
> openSUSE Leap kernel. Checking with upstream I've found out the issue was
> accidentally fixed by commit 2729cfdcfa1c ("ext4: use
> ext4_journal_start/stop for fast commit transactions"). Can you please pick
> up this commit into the stable tree? The problem has been there since fast
> commit began to exist (in 5.10-rc1) so 5.10 and 5.15 stable trees need the
> fix. Thanks!

This commit does not apply to those branches, so how was it tested?

Can you send us backported, and tested, versions of this commit so that
we can apply them?

thanks,

greg k-h
