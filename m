Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C83164CCF4
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Dec 2022 16:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiLNPTa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Dec 2022 10:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238655AbiLNPT3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Dec 2022 10:19:29 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD01FF18
        for <linux-ext4@vger.kernel.org>; Wed, 14 Dec 2022 07:19:27 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2BEFJ0TX032577
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 10:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1671031142; bh=lFLQBDC+4nysDRvLa80at6hXNhWnqYY2vPKTa9emJEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Cg7T1VkQmIjODXICzBsU3oPQ3+4Nrdgp77NNpTvOz7oZvn7zc9u6YUGRAX9dKV9uq
         K810gweno/UtiNsGoigITcJ7hHszjr8assN99odE23PMvMzAo2aXDTHhQCTdjXxFCr
         vexJ0nWzK5S4wqNBtLeZKirxNPdX7jBToRHS0p6QFWXeH9UE3zM5j9QYPOmDa8IZ/N
         59BmtwA5nGqIpE0XZuIKKQKZYn8Bo6qdbUCrEnwAcRsh65UfDFOh7BHfBdUz/wmqwi
         V8oWrTivAG9O/ktQvyO/jXalg//L/As8xGK7F7cVZbfb0qH6oWQL4WZXLHNsu10OhD
         CbmVfzRLnDItw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 53D9815C40A2; Wed, 14 Dec 2022 10:19:00 -0500 (EST)
Date:   Wed, 14 Dec 2022 10:19:00 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     yebin10@huawei.com, jack@suse.cz, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, heng.su@intel.com
Subject: Re: [Syzkaller & bisect] There is "possible deadlock in ext4_bmap"
 issue in v6.1 kernel
Message-ID: <Y5npZPh6HEUOmtut@mit.edu>
References: <Y5lO7xPYh/c6Qyq/@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5lO7xPYh/c6Qyq/@xpf.sh.intel.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 14, 2022 at 12:19:59PM +0800, Pengfei Xu wrote:
> Hi Ye Bin and ext4 expert,

Please include the URL to the syzkaller dashboard where these things
are reported.  The dashboard includes a lot of useful information
which is not included in your report.

It's also better if you reply to the syzkaller report that was
originally sent to LKML and/or the linux-ext4 list.

						- Ted
