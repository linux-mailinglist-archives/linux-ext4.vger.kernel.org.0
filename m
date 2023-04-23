Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96B66EBC70
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Apr 2023 04:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjDWCdU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 22 Apr 2023 22:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjDWCdT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 22 Apr 2023 22:33:19 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524B81717;
        Sat, 22 Apr 2023 19:33:18 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B65063200495;
        Sat, 22 Apr 2023 22:33:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 22 Apr 2023 22:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:content-type:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1682217195; x=
        1682303595; bh=bzjFJF8i4h0k780+vILhhBwCTdIlS1yLGzDitiHYXY4=; b=n
        kd15zKmtYPGCOgPPJBrlr+u6Dfwb2bFjPemJPXaYf/2e23sy/CbClrtD1q2T5E84
        NKQmpACPRl5apF2bCdLIL930DNZgbrP08IbUTV3sUKs2gUu6RxzU/U63MOg5y5qp
        5msX0Q9XBl+Q+6wfIqNNQoq/akxua8mueB6I24SThtevrYEKaT4Fob7kCt8/9ufm
        01+OpF+RaNCjjjNI35WCa/doKK+9iDf5aiQIt5ZwaYTAPpD6jm939EsYm6+X1OSG
        U82qCbnw6OWOY2P3EdzLhbXnVEVgWzqNwQaa19Tk2bkHi+FA3KErKiOvOKkiTgr4
        5a4pmoljof/UBLLdqvupA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682217195; x=1682303595; bh=bzjFJF8i4h0k7
        80+vILhhBwCTdIlS1yLGzDitiHYXY4=; b=BCdVtL5ZnM+KVQMnOty6a5n63PHR8
        MquQr1mmCzIMCOkUNTRnoo31NZbUy1xOGr0UloU0wao5b2RMPwvPKbkhO8Xu5b+n
        4bNxvESBQiv2+fNZYslTgKGZ4EM+dwB08aZuOZRqN+/Xx7bvNdbDTagk731kuTkX
        +sBt0wlOqGXAOEVYx+VzgS0TsUDWpakEw9TCAZY7uwGStCmIBKNB4/adn2zObmGU
        oYLW0VAtOLjbrMev6/d5jhiWeOxBZEFo2cpDYvniYEajZRveyEtGRCu+uDtI2XSb
        nZof1ML6GsM2PlyE1ly4UygbzbzopyL9nlMM0NytRLPNL18UppGA1rbPQ==
X-ME-Sender: <xms:65hEZFcz089UFGntcLnW3HweD8WYqhPR1R7hSHFEqRXdV-HtNCuDZA>
    <xme:65hEZDMiN0sRTeZCPazFKPNu3PZ6rKtiOj0ysysjIliTLSpw4k67VT3o3UBcJTkzC
    4V9IJN3atC87jMAM2c>
X-ME-Received: <xmr:65hEZOi5l0foAikeBDYGrx-KvCyu0VrN-zgx4YIoHkH3cv6ktemgYgMG1kV936R2F0mqYg-MZ6FtKu14TEh03Fy1RA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtjedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomheplfhoshhhucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhh
    thhrihhplhgvthhtrdhorhhgqeenucggtffrrghtthgvrhhnpeegtdfgfeeghfevgeelgf
    efieegudeuheekkedtueeutefgheffveegueeiteehteenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjohhshhesjhhoshhhthhrihhplhgvth
    htrdhorhhg
X-ME-Proxy: <xmx:65hEZO8DZKOsKAD6Xt5n_LtzmX0XnaNjVg4EqEl0QSvqhN7xYlGmMQ>
    <xmx:65hEZBsrtovArJey3oEqtAbJ2mVw2WAVbghlXZBFNTfBMnWG4_dJ6Q>
    <xmx:65hEZNE4Fc8A0Ku4sztLJxyB-a9hDuuCcDxuHZxra6kKjU88uQL_yw>
    <xmx:65hEZK5g8-PvX-sXc24H8iBtKkPLrCP6ha0nb6fr3dhYETh4YJgBkg>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Apr 2023 22:33:12 -0400 (EDT)
Date:   Sun, 23 Apr 2023 11:33:08 +0900
From:   Josh Triplett <josh@joshtriplett.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3] ext4: Add a uapi header for ext4 userspace APIs
Message-ID: <ZESY5NAN8+7ubDLk@localhost>
References: <680175260970d977d16b5cc7e7606483ec99eb63.1680402881.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <680175260970d977d16b5cc7e7606483ec99eb63.1680402881.git.josh@joshtriplett.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Apr 02, 2023 at 11:37:52AM +0900, Josh Triplett wrote:
> Create a uapi header include/uapi/linux/ext4.h, move the ioctls and
> associated data structures to the uapi header, and include it from
> fs/ext4/ext4.h.
> 
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> ---

Following up on this: would it be possible to get this in the 6.4 ext4
pull request? It'd be really helpful to have this UAPI header available,
for the benefit of tools that generate bindings to ioctls.
