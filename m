Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146144DA3E4
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Mar 2022 21:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244655AbiCOUXT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Mar 2022 16:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240594AbiCOUXT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Mar 2022 16:23:19 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D84335269
        for <linux-ext4@vger.kernel.org>; Tue, 15 Mar 2022 13:22:06 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id s14-20020a056e021a0e00b002c7c03a5d81so203998ild.9
        for <linux-ext4@vger.kernel.org>; Tue, 15 Mar 2022 13:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WEkhoTVVedY5DexXEQJJfW/um3h2zWtR80MaPcoaP2Q=;
        b=Q3gZcZPrAvGl6DJvF+nqBjWGWnBIyiyQTOgviEH9swV8Z0809vW+RVJvPwU74UNOg0
         eZdQ6JVjQxLnydyf1SxYLn3beXWPMEjvrPNFGttn7oSSoElHe/pUljKDrdLWcQv2EVsm
         ORGaz4PcysPyBCWZ5bDN/V44z6YJ0FY8LEvB90I0S8oEkF6Zs/+S9OTQ/pDIaXhQxr8B
         GSBTzxqq9YCaF7Zogp2/YWDnnHnfFKIfZGZl0GWRTxCa6KGgx5VrpCTbjKcWI84H7xWd
         01uwESGpHUdTvP9aBiWKmU27U0zIw1q8O7KoabjTRblMsFxXrRxL6S2PGFh2pKEtmeFf
         E7pg==
X-Gm-Message-State: AOAM530nDED5ZQvKEhT5PaarsDSjImVLgAjmRlbmkbzKOtzopnnPJ0qS
        bUdBxP4OT37htBwJYX5PeCqNSULU4IItSzLHVKxHXW/1yzZM
X-Google-Smtp-Source: ABdhPJy27TvSFLmnt7700rf9BDQ+MGeQcOZFU2USh3j36Mwz659RgtdxE7YraE1wqVt42BhXVM+2W4Iz7z9xA/vdB+E2ah1B6o8H
MIME-Version: 1.0
X-Received: by 2002:a5d:8552:0:b0:63d:8cae:b2ca with SMTP id
 b18-20020a5d8552000000b0063d8caeb2camr23112544ios.81.1647375725894; Tue, 15
 Mar 2022 13:22:05 -0700 (PDT)
Date:   Tue, 15 Mar 2022 13:22:05 -0700
In-Reply-To: <a30ec1e7-564f-665b-7c20-54dad6124418@linaro.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f422ca05da478cae@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_ind_remove_space
From:   syzbot <syzbot+fcc629d1a1ae8d3fe8a5@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tadeusz.struk@linaro.org, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/ext4/inode.c
patch: **** unexpected end of file in patch



Tested on:

commit:         56e337f2 Revert "gpio: Revert regression in sysfs-gpio..
git tree:       upstream
dashboard link: https://syzkaller.appspot.com/bug?extid=fcc629d1a1ae8d3fe8a5
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14bf8361700000

