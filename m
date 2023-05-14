Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95968701B7E
	for <lists+linux-ext4@lfdr.de>; Sun, 14 May 2023 06:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjENEWc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 14 May 2023 00:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjENEWb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 14 May 2023 00:22:31 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4031BF4
        for <linux-ext4@vger.kernel.org>; Sat, 13 May 2023 21:22:30 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6439b410679so7570571b3a.0
        for <linux-ext4@vger.kernel.org>; Sat, 13 May 2023 21:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684038149; x=1686630149;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9XatWSFnxA2IsJDbagxD67Oj8VQ6lg3ba5GKYE6rI9Q=;
        b=pFexOuzCCKeGDfSPPZ3MP5rxuzX1Bi6CkBGIYl5iGsVrWkRw0QqQ3uCOW9cQx4iQL8
         oJQqhHCS9A1KZGDCuCzqK79eXm0b6hVEHY+EbfzFbFk/L49pa7mxCRdzXPLxKb7gvdE7
         IpkhCC/Jp1GOkTdgjDbq7FoNdWYBpSEBYzB4G7ibP8Uf8deVpt6gYdWgwqQtp/Os+Jl2
         Mq1tCX8g5UyS3YZmKbW8hIfTXyIjWWTLytmEStw3Y/4VaDsDufZRfTXpqc+ZHY95kX98
         cLo6hQ7KwwNgnttlaSqgJCwqR4vNjF1NgUc4Y/YFD7qqGZGeCN13yDfJxJ10jEO1cNjb
         s9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684038149; x=1686630149;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9XatWSFnxA2IsJDbagxD67Oj8VQ6lg3ba5GKYE6rI9Q=;
        b=L/j5J4TJEITFdwrdVZaqocuW61LznbPCTdZVU5a3oPlrRil6QachxnluWSp19fMyBd
         IGanRYngqLDk4xulfH4lRPkudkpfmNJ5buZD+SIzC0JR9hlT6mnA6OTTtAvjTes2ZgzT
         YZZSNYCRWQC1tNLcKelPunJzDwBvD/3MVXSIqn6S6ErYGotIpxW57TPOLE907C4i8cm7
         baYWooZETVWqpwHdzVIKsRTzke17u8oCwHoARBA09A69C+5ZnHAJLvsf/8FhSNskXUct
         n1CN+OJe+Vp/raJLGTn6FFS+Z6HbgYlWZ1zEGCIByF1Y8aFDvltTJvL7/PIeH9/iFTGF
         9m9Q==
X-Gm-Message-State: AC+VfDyJAxzUf7mNew2upf1wan9N5dMIJfYMSYAu59R8bVBjXUlFjf8g
        uyXzSj0laUrqSaRqKQOTmCc=
X-Google-Smtp-Source: ACHHUZ5i+roZO6hLYIExgpbD4eHflUB3F9Q5sNHKR2na+08/vOgqPZycbLNUa+n7JdXnVslDONSxHQ==
X-Received: by 2002:a05:6a20:7d82:b0:103:4c5d:667a with SMTP id v2-20020a056a207d8200b001034c5d667amr17262241pzj.4.1684038149330;
        Sat, 13 May 2023 21:22:29 -0700 (PDT)
Received: from rh-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id e10-20020a6558ca000000b0051b0e564963sm8714735pgu.49.2023.05.13.21.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 21:22:28 -0700 (PDT)
Date:   Sun, 14 May 2023 09:52:17 +0530
Message-Id: <87ttwfee4m.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv1 0/4] ext4: misc left over folio changes
In-Reply-To: <ZGAHO2rwgR4ju3vd@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> Hey Ritesh,
>
> My understanding is that you are intending on sending a revised
> version of this patch set; is that correct?  Thanks!!
>
> 	   	      	      	   - Ted

Yes, Ted. I had some open questions to willy mainly in Patch-3.
Let me rebase this and will put the queries in the rfcv2.

-ritesh
