Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8CC72617B
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Jun 2023 15:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240212AbjFGNja (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Jun 2023 09:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238619AbjFGNj3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Jun 2023 09:39:29 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CE019BC
        for <linux-ext4@vger.kernel.org>; Wed,  7 Jun 2023 06:39:23 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-119-27.bstnma.fios.verizon.net [173.48.119.27])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 357Dd99L023640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 09:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686145151; bh=mOlaIipWXbX0KCSSQsOCrVq9cmkvIs44WVR++qJ9SwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=SlZp15sTVbk5GUgEvnDv/tTsG/zXzhnMd96i0pnTn2mum6Glf+4EH3yL3UxNpPano
         CMH3Hgdhisy4ROAat4Y+duJeRsMoXbbWyc2Rxczr6ncIhIs/vObqlF8mXRlqbYP0VB
         khFTuwh2hU4VoQ5qe8CH3/hcy6/cv0NTOy05zgKC52ijQ/yqNLBpRuuApLRWX82alk
         TXMmrwpZYxOS56bXap1zeK+ilXFbXhlT8KbRPxGYe+6fDB8P5YMPhfGTIPN0AXf5Wv
         CcChQ3gqXTs+in6uA5/SWG1eUBqRCqTL0BCCbGgHh3Qq5FBNLvGQcJESXGl95zx3pu
         CY01DbMHrj1Qg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B5FE615C04C3; Wed,  7 Jun 2023 09:39:09 -0400 (EDT)
Date:   Wed, 7 Jun 2023 09:39:09 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [e2fsprogs PATCH] resize2fs: use directio when reading superblock
Message-ID: <20230607133909.GA1309044@mit.edu>
References: <20230605225221.GA5737@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605225221.GA5737@templeofstupid.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 05, 2023 at 03:52:21PM -0700, Krister Johansen wrote:
> Invocations of resize2fs intermittently report failure due to superblock
> checksum mismatches in this author's environment.  This might happen a few
> times a week.  The following script can make this happen within minutes.
> (It assumes /dev/nvme1n1 is available and not in use by anything else).

What version of e2fsprogs are you using, and what is your environment?

Are you perhaps trying to change the UUID of the file system (for
example, in a cloud image environment) in parallel with resizing the
file system to fit the size of the block device?

     	       	       	       	   - Ted
