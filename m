Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A75175937A
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Jul 2023 12:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjGSKyv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Jul 2023 06:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGSKyu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 Jul 2023 06:54:50 -0400
X-Greylist: delayed 174 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Jul 2023 03:54:48 PDT
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B79123;
        Wed, 19 Jul 2023 03:54:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689763901; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YFE3oRIx5xOpJJkrH2X2V/kuuQ7dXiLg6xxrLpPcYM1jXz/zzdjAmrmf7fhceOM82S
    ogQt+TotYoe4773Jn4uPBastZLsaOi5ir+Yp/hYlK/JMtvpI/hnUvg8G1UvuOOwqCXJy
    v/WXn4jrRkn9pIIS38ychBdfiC5qOVdrlsko6a/9Zgwu6+QViFS2VVLTXdRObFf+5uAl
    aWNzDbdaH4lJr4X0gnmsnm/eXTRBUQEe1seBJuuBbHNTIrP+SmsGZ+33cTeT7K+iqius
    SOinfVhCFIZS/w4je3ypKMMvS5P46s60emDY3ZPb2quw3BCzrfsTO4WgKqivc7jP+0Bw
    RzTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689763901;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=lvLGZstJ8wKorYy8rcLHdorayXbsT3iQ7MhbnharKpE=;
    b=qHzVZrne5P4O25MRsho6FvQgsyWrjfiVzZJ31HhjAf92pDc5FhipQRyQaM0r4WjRN1
    GkgVDC9q01lwiiKwPFhmyETrYmjJs5hpn1bb0ymnf459wNtzCFSTMcWKiCGpy/SQdNbe
    ebKNXXKFTSLyoN8hJo+KoFV1Jw3+dPzfEqL7LgvLbxdBZ8SxTqmeF3zDYp1Y8vnroC0c
    Sm7uOnQ2QWaZW0hFxmhVe1ceA6RgOcSEgi3lhBjoipSGjQmyr1nw/1gQ7pG50qGrn+8e
    mRoTUA+V34KsQj1jetUEkePgvJBdiofQAohbWFRtLFDDmVTx148I+3O1tVrExTBMDfvC
    Sbiw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689763901;
    s=strato-dkim-0002; d=tomerius.de;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=lvLGZstJ8wKorYy8rcLHdorayXbsT3iQ7MhbnharKpE=;
    b=M3N9Gj1Ihv8I9YUfstwtzWIFX3+X2U9J5CpGZ6oP7Di3hrzt3WsVVJv1AOAErs7Ove
    CUu06Y8twnNwBNCHrSlB2nck7Vs5gxPbe0zltkHifMwKwABBUophuepqxMzpFUdWTCA3
    Qap36HEHkzX9ZZ59g3CLLXZob5ZWjMinDx1ttADn2Ah8kn9kYVxYd6Lxygin2qWGA+MY
    MruND7adGncDE2d/mlXQ2mp/HQtqB/n1A3qAQ11K0HNW7hKknR+WGr1NyByh5uKO+I5l
    QtnBiarBhsYIBGx1XvhsYuZVbmKa+oCrmut3yi6UzUbQBfaIZEcBZGhDCEi1c+nXbBDa
    +uiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689763901;
    s=strato-dkim-0003; d=tomerius.de;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=lvLGZstJ8wKorYy8rcLHdorayXbsT3iQ7MhbnharKpE=;
    b=izeiG+UjQBLTpfzhdAuho9H+oPiIG8m14QCvDr/1SnrXC/4LZIUG7e8H9/IuiaHNyB
    l7nJ7yHBtDsAwrCpWADQ==
X-RZG-AUTH: ":J20NVVSndvp4466vFhCXUxk5AzpkHwfKmUFBoZWB6MoGGjIYlcL1veuiArSdmAK/Sg=="
Received: from jukebox.tomerius.de
    by smtp.strato.de (RZmta 49.6.4 DYNA|AUTH)
    with ESMTPSA id Y0a99ez6JApf0CC
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 19 Jul 2023 12:51:41 +0200 (CEST)
Received: from [192.168.3.20] (helo=tomerius.de)
        by jukebox.tomerius.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <kai@tomerius.de>)
        id 1qM4mS-0005X8-JQ; Wed, 19 Jul 2023 12:51:40 +0200
Date:   Wed, 19 Jul 2023 12:51:39 +0200
From:   Kai Tomerius <kai@tomerius.de>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Alan C. Assis" <acassis@gmail.com>,
        =?iso-8859-1?Q?Bj=F8rn?= Forsman <bjorn.forsman@gmail.com>,
        linux-embedded@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        dm-devel@redhat.com
Subject: Re: File system robustness
Message-ID: <20230719105138.GA19936@tomerius.de>
References: <20230717075035.GA9549@tomerius.de>
 <CAG4Y6eTU=WsTaSowjkKT-snuvZwqWqnH3cdgGoCkToH02qEkgg@mail.gmail.com>
 <20230718053017.GB6042@tomerius.de>
 <CAEYzJUGC8Yj1dQGsLADT+pB-mkac0TAC-typAORtX7SQ1kVt+g@mail.gmail.com>
 <CAG4Y6eTN1XbZ_jAdX+t2mkEN=KoNOqprrCqtX0BVfaH6AxkdtQ@mail.gmail.com>
 <20230718213212.GE3842864@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718213212.GE3842864@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> In answer to Kai's original question, the setup that was described
> should be fine --- assuming high quality hardware.

I wonder how to judge that ... it's an eMMC supposedly complying to
some JEDEC standard, so it *should* be ok.

> ... if power is cut suddenly, the data used by the Flash
> Translation Layer can be corrupted, in which case data written months
> or years ago (not just recent data) could be lost.

At least I haven't observed anything like that up to now.

But on another aspect: how about the interaction between dm-integrity
and ext4? Sure, they each have their own journal, and they're
independent layers. Is there anything that could go wrong, say a block
that can't be recovered in the dm-integrity layer, causing ext4 to run
into trouble, e.g., an I/O error that prevents ext4 from mounting?

I assume tne answer is "No", but can I be sure?

Thx
regards
Kai
