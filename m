Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA6B97B664
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2019 01:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfG3Xty (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 30 Jul 2019 19:49:54 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41995 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfG3Xty (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 30 Jul 2019 19:49:54 -0400
Received: by mail-ot1-f65.google.com with SMTP id l15so68214736otn.9
        for <linux-ext4@vger.kernel.org>; Tue, 30 Jul 2019 16:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YZGVD9T/ISCyZIXUuaqTJBGeGochIMRFNbcsevrfj6k=;
        b=y2gLl0uawibzBuQUpy+9TiIBc5esmP23Xp+fa8x2kOUA1XGQHcDbEsR2i5UOM/RrvQ
         fgl4AfWV6GBoAhwQ/HwJcWRRXQQiXseEHDmsQ4ji0oMe2Jos1fWr6L/6IIEQL4vn+m6I
         39T81XyTUmMYioKO0tY/MuIWgqNeqDx8dzunpj8Y94lZweXuI1iRXyUIQ3zFJaSu2Xxw
         IHYh14s9JHhGisf/jnyohIHv7X8APsC6yk2s54IT6WVf03UK4eZlIS9sHPNn0QuzGamH
         xwoz8RZEF3BaDAQxJNH3t/6dZwto4DEuMF+2cwmr4RvBXCYg5fSHw6o9de3CRUR6+aPr
         FjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YZGVD9T/ISCyZIXUuaqTJBGeGochIMRFNbcsevrfj6k=;
        b=aQHHVKjcCi/vvqDiDvpq5SsjzNUhie0w9moE4e4zOOG3A87WEGO1XQKUx9Cw9+EAGp
         8pR4IvEB0QTpLA0DfYMQcEnT4fHMK0DtbBDhKy1KZgMIeXqjqeY2YL411/CKZ0iVGyYr
         DXLJW7E9+Neu9Ss9ZirBkv7KTwumW+yTXpxvZgQCo3nF9VOMRbBymRnL6u/PQu9hU3Qd
         h4zge2IDAi6ic3Af1xWawLotOaFCwYyPUjED4YlQU9z/RDDD7O9jaBPeUne+iDdJ68I1
         eMSYuGp4MvQV3YYahWIFrUK+J2PGKLSD7kmGYs4ETSAAae8HQaiW54bBmxa4vXY/xbW7
         OoEg==
X-Gm-Message-State: APjAAAVNgbjpetl+/5vhVW2rhukUBmts/al572xaDQvERx+MQMMNbpq4
        MQUMW7eIZJolKgYhYTOj7zDu15ZExQbgD6TT0+lPeyij6PU=
X-Google-Smtp-Source: APXvYqxpVTpWXl071uM60bZDAVuAEoeakVRsDBk+Vn+kv9oOLQo67gsmcz8AqZ+JJcM0pkL5JjbY4BtLyUgaRYK+utk=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr11711647otn.71.1564530592993;
 Tue, 30 Jul 2019 16:49:52 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 30 Jul 2019 16:49:41 -0700
Message-ID: <CAPcyv4g1g2i-9p1ZDqy596O-cbw3Gas2wdiv49EvM+b0i-1uLg@mail.gmail.com>
Subject: dax writes on ext4 slower than direct-i/o?
To:     linux-ext4 <linux-ext4@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>,
        "Berrocal, Eduardo" <eduardo.berrocal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi all,

Eduardo raised a puzzling question about why dax yields lower iops
than direct-i/o. The expectation is the reverse, i.e. that direct-i/o
should be slightly slower than dax due to block layer overhead. This
holds true for xfs, but on ext4 dax yields half the iops of direct-i/o
for an fio 4K random write workload.

Here is a relative graph of ext4: dax + direct-i/o vs xfs: dax + direct-i/o

https://user-images.githubusercontent.com/56363/62172754-40c01e00-b2e8-11e9-8e4e-29e09940a171.jpg

A relative perf profile seems to show more time in
ext4_journal_start() which I thought may be due to atime or mtime
updates, but those do not seem to be the source of the extra journal
I/O.

The urgency is a curiosity at this point, but I expect an end user
might soon ask whether this is an expected implementation side-effect
of dax.

Thanks in advance for any insight, and/or experiment ideas for us to go try.

Eduardo collected perf reports of these runs here:

https://github.com/pmem/ndctl/files/3449231/linux_5.3.2_perf.zip

...and the fio configuration is here:

https://gist.github.com/djbw/e5e69cbccbaaf0f43ecde127393c305c
