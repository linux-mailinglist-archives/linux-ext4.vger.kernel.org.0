Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CA8755EFA
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Jul 2023 11:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjGQJI7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 17 Jul 2023 05:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGQJI7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 Jul 2023 05:08:59 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0B0E55;
        Mon, 17 Jul 2023 02:08:58 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso4641745276.2;
        Mon, 17 Jul 2023 02:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689584937; x=1692176937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqUV389bcHJRJT6iwuWrxWbjzHQ6HHBmo47jvW7D/4Y=;
        b=TSJQ5DFgUxw7vGxWnTmX+RxBJcWWKv967h9iXZX5K47mZnKOuCdLGxCE+s0vq1Kw6H
         VTwUEeTAybTaHIaO+e178LUF80NRf/ZFCHXRwg7x+77vvxwyFelOrSv87r8HgfEEgjv8
         hj/R8Eh8KHfUrmSxd5gknwHqGkCr5A+UkSZ5HnCicNK/OYT1SfRc5UmqbfwTzXokZmgU
         VZYPQc6bWOW53uqy4pwg1mER5xkhK+EiHp3cNFwCm0gmOXRkhpAAPkbvpMRiOmd70fmG
         /D3CnEbRcNOoT8/JtTO5Aw0nHZgtaIr9jYhOy24uJ4OTiUovjxMB5NbeOspyCIF33BpK
         M83Q==
X-Gm-Message-State: ABy/qLa1Hi+4zHlGNY97D/BIkEoyFxtHw+YWJYnkmRoZoPF5N7oLjGKi
        3KQDdjrWvPHbDNcUeF0pM+b18QOgnO3I3g==
X-Google-Smtp-Source: APBJJlGBCEessdxqn3hTFKfcuf2JQWNboTrRqtFis9Ha9tlxH6NLs4vAwGjEHB5o8j1qCuBArO+Wsg==
X-Received: by 2002:a25:a1ca:0:b0:c83:add0:889e with SMTP id a68-20020a25a1ca000000b00c83add0889emr12612978ybi.23.1689584937278;
        Mon, 17 Jul 2023 02:08:57 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id z23-20020a25ad97000000b00cc7d43b524csm935330ybi.31.2023.07.17.02.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 02:08:57 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-c2cf4e61bc6so4634733276.3;
        Mon, 17 Jul 2023 02:08:57 -0700 (PDT)
X-Received: by 2002:a25:ae51:0:b0:c63:7093:dd01 with SMTP id
 g17-20020a25ae51000000b00c637093dd01mr12173716ybe.27.1689584936882; Mon, 17
 Jul 2023 02:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230717075035.GA9549@tomerius.de>
In-Reply-To: <20230717075035.GA9549@tomerius.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Jul 2023 11:08:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWA+2froa9Z=GHrd5Ub-dr=o-ErNsgjS7TJnXbHYggMdQ@mail.gmail.com>
Message-ID: <CAMuHMdWA+2froa9Z=GHrd5Ub-dr=o-ErNsgjS7TJnXbHYggMdQ@mail.gmail.com>
Subject: Re: File system robustness
To:     Kai Tomerius <kai@tomerius.de>
Cc:     linux-embedded@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

CC linux-ext4, dm-devel

On Mon, Jul 17, 2023 at 10:13 AM Kai Tomerius <kai@tomerius.de> wrote:
>
> Hi,
>
> let's suppose an embedded system with a read-only squashfs root file
> system, and a writable ext4 data partition with data=journal.
> Furthermore, the data partition shall be protected with dm-integrity.
>
> Normally, I'd umount the data partition while shutting down the
> system. There might be cases though where power is cut. In such a
> case, there'll be ext4 recoveries, which is ok.
>
> How robust would such a setup be? Are there chances that the ext4
> requires a fsck? What might happen if fsck is not run, ever? Is there
> a chance that the data partition can't be mounted at all? How often
> might that happen?
>
> Thx
> regards
> Kai
