Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BE65AC646
	for <lists+linux-ext4@lfdr.de>; Sun,  4 Sep 2022 22:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiIDUKA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 4 Sep 2022 16:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIDUJ7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 4 Sep 2022 16:09:59 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9DD21E01
        for <linux-ext4@vger.kernel.org>; Sun,  4 Sep 2022 13:09:57 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id q8so5222944qvr.9
        for <linux-ext4@vger.kernel.org>; Sun, 04 Sep 2022 13:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=o53iSUwBo85Om+P0ni62icGxGsI1yWNb5l6eiHTq1mc=;
        b=oGYgN3ochr9DlIAyTj/i5Ku5D39MNt2W3pSWJL1Ovne5GJv2gnVULCt14k39UWbOOv
         zwz/atyDiGopD9GsK71qq3j+GXx1pqPgBBrzAFiB+NK3pgpY90wZO0LW3HAW7BsCu6Wu
         +6Ka/UeCy89vqKDRqVms0hZuAQ7Rvg51F0artV3g9bAkBswT/cSM8WXfRWveCK3EvAvZ
         mAfDZECebhS0wigb+DH9dUjLGYK16gMdLv9/zOzABPDNwDbate7sWmyk2cJjJqACFM1O
         wBMg2gXYENv4AKxBOWGUpFFYIuQr+gh1++UlGIqbXoo8MCgsge2pdM+mCfKAL70i5UX8
         BbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=o53iSUwBo85Om+P0ni62icGxGsI1yWNb5l6eiHTq1mc=;
        b=oJ72laO3qe4COMKF9iz1VHWGOdqoJ+73xIFk4P0pHMpCcc7HQuAh1dtYkP4KckO2S/
         2LAtfLuu5NehZG9cu+8AMJcz7uhrv+1mp/d//7T0zTlcHtXlHzBMhkl4i9K9+fhotTDD
         B1T5T4DlLSIbPC1hL42BW+NL9q4N6KeYSrB8RBwIePhzf1A/v6biAdDVyL8hwdNOZ85j
         zMKoM3GFqDzUiSVRBNBrbZ4wCVtXoXI6S6YTpZOFR1lNR17yJa3CXknMJ54Mdwaj6xcO
         yK8hZOrIgv4B2fuE04/vHJVWZouwlGsnPiB+Bboqnhk8mcINJAbi3yAPMB1FYazbPATi
         ABfA==
X-Gm-Message-State: ACgBeo0aWL5k2CPuwDJbYfucvHLQphoF5jv0dncBGlSjlf61OCOgXo/Z
        QyOi/V6wCl1eHuehDe1yM53nlCY4hUk=
X-Google-Smtp-Source: AA6agR7Cv4lCW0eNh8w/h2/jER/Rgp228u0DAPR6JVL7W/NoJbBoCx/w6MwHnIRS8jx2uVoL8OAhfQ==
X-Received: by 2002:ad4:596a:0:b0:499:105:1d8f with SMTP id eq10-20020ad4596a000000b0049901051d8fmr31546607qvb.71.1662322196746;
        Sun, 04 Sep 2022 13:09:56 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 (h96-61-90-13.cntcnh.broadband.dynamic.tds.net. [96.61.90.13])
        by smtp.gmail.com with ESMTPSA id u17-20020a05620a431100b006b9c355ed75sm6548433qko.70.2022.09.04.13.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:09:56 -0700 (PDT)
Date:   Sun, 4 Sep 2022 16:09:53 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org
Subject: kvm-xfstests, adv test scenario, inode size-related failures
Message-ID: <YxUGEewB0AdMPTfl@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted:

I'm seeing a large number of test failures running 6.0-rc3 on the latest
version of the test appliance in the adv test scenario.  All of these failures
share a common feature - mke2fs fails to create a scratch file system using the
inline option because the requested inode size is 128 bytes.  This didn't
occur on the previous version of the test appliance.

It looks like /etc/mke2fs.conf contains an extra relation for the "small"
stanza: "inode_size = 128".  This isn't present in mke2fs.conf in the
previous version of the test appliance, nor does it appear to be in the latest
master branch version of e2fsprogs (perhaps I'm looking in the wrong place).
Deleting that line from /etc/mke2fs.conf on the latest version of the test
appliance eliminates the failures (as does modifying ~/fs/ext4/conf/adv
to specify a 256 byte inode size in the list of mkfs options).  The previous
version of the test appliance applied the default mke2fs.conf value of 256
for the inode size, so mke2fs didn't reject the request there.

For reference, the tests that fail for me include:

ext4/021, /036, /038, /039, /048, /271

generic/015, /077, /081, /083, /085, /204, /226, /250, /252, /371, /399, /416,
/427, /449, /459, /500, /511, /619, /626

shared/298

Eric
