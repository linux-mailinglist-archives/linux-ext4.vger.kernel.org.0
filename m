Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A765448AC
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Jun 2022 12:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbiFIKWs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Jun 2022 06:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiFIKWr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Jun 2022 06:22:47 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347DB1FCC5
        for <linux-ext4@vger.kernel.org>; Thu,  9 Jun 2022 03:22:46 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a10so20970366pju.3
        for <linux-ext4@vger.kernel.org>; Thu, 09 Jun 2022 03:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yajfj+kLqUG0WqKZHElcKbwvSUfBoW24MZxnWR7qgpA=;
        b=fHfFAQQZYweNlMrBzSL6ji2t9FvKDz7o3IyVGQRW0klR6lfkZAx2Rqtyybc4FJwZMy
         T0XkHyUfPDXuzEdQNl50dVnLQsyNKTLYoBHiZFlantJTlSjSXHrJzUrIYNnKv+1rEJiz
         W2D6H6IK+Gv6fsaq8jIm+4qZ7qjKyt2cOPDyuGOAYnxPhbBtI81IA+AtOiwpF4yTVnBM
         9iBsJSCI5V1ifVVgrHxR76oMWR82gFo+sWgNAea5pA/RWTLfewrj/9Nfxj2PSgdpYBZN
         kjz8JS05t8rjbniKjBzNFpVYcPP11W1wX6igrFjjFYa65kuc+0VO+VQam3cC/2r9Pimn
         VcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yajfj+kLqUG0WqKZHElcKbwvSUfBoW24MZxnWR7qgpA=;
        b=Hg5s+4HCYmW4etlQhRspZiexUxT4ktvAs7Er5RgniIcWjEX8qAhE7mWsv8fwYPpvpB
         hmVrp36CXc/0aLMTveYAiRWOwccaHzYMpMNySTflxwSubL/oE4BRgjNjfW0YVxpw0Qal
         2DDmZwM1aUmqJeR0fj53E2d0u8f43YzXmWJPIv09HdS1uuybu9he3z4FdYWVIFy47ROY
         f68Qg3UpopMolPHy5CTD65+m0X1SRj9FUYDBP5cfjNyX9QgiTjfPE73ad3k1Q+c7i2fH
         FDCAa8yOD5uLkyZrnv5x51DYpoeru4isXqqW8ZfLSTo+QBIAkIge4gr95li5mgLAOf3E
         aEWA==
X-Gm-Message-State: AOAM531KRcbXKp3k+EnWv9203S8Qhf9zHGjXyORjC21ScQPM51lY1jVh
        oj98e/yYqwUMZsD3Ca5j2JQ=
X-Google-Smtp-Source: ABdhPJxQJ0OreNzNe066eSqu1qkT5rc7AXyIQDBreszzNrcp2iZbPd7oV5TwemvblM9HaDE851NpjA==
X-Received: by 2002:a17:902:c946:b0:163:ed13:7ab1 with SMTP id i6-20020a170902c94600b00163ed137ab1mr37923869pla.36.1654770165690;
        Thu, 09 Jun 2022 03:22:45 -0700 (PDT)
Received: from localhost ([129.41.58.23])
        by smtp.gmail.com with ESMTPSA id u1-20020a056a00098100b0051bc4ed56bcsm9196041pfg.204.2022.06.09.03.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 03:22:45 -0700 (PDT)
Date:   Thu, 9 Jun 2022 15:52:42 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/4] ext4: Debug message and export cleanups
Message-ID: <20220609102242.bacrxpbzmr6qazsq@riteshh-domain>
References: <20220608112041.29097-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608112041.29097-1-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/06/08 01:23PM, Jan Kara wrote:
> Hello,
>
> this series cleans up couple of things around debug messages in ext4/jbd2
> and removes some unnecessary exports.
>

I had noticed these jbd_debug() calls too in ext4 code and wanted to clean it
up. But you have cleaned up few extra things too :)

I have looked at the patches and it looks good to me.

Thanks
-ritesh

