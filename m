Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4126D16778
	for <lists+linux-ext4@lfdr.de>; Tue,  7 May 2019 18:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfEGQMT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 May 2019 12:12:19 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:42815 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfEGQMT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 May 2019 12:12:19 -0400
Received: by mail-io1-f47.google.com with SMTP id c24so2100704iom.9
        for <linux-ext4@vger.kernel.org>; Tue, 07 May 2019 09:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Nf2iVqNOtbifDZcrGvUmE0lDgcMP81Su7AlPzQDta48=;
        b=ekXeAiM+Ga5gch50IrVK8SVojbxTH4qoUfFdV099UkuGj+gm8xIuMefMx9Oy6zNKTV
         OKdzMpS9HsoHnqgOy7695Gd90Jt2HdtuWAqug1XNdkvCCDibTmqmT0WZysn3okU2nZMu
         eJ9gh/9eTaU5zlewz9/jL+4P1b4q5ivOZrnDBxVmMSO3L3/tMPW/u0n3LE8MM9+L3CcW
         KK3jk+y5NT8uETHy7DEKdNo5VwhPP00oXtQqT0boZDFOYpxgP/lTEDbOUs12TVgtgfQY
         +IbsaOsHyWgiaORwaPzaKefeEU2VQkQnNtFArVXSorSUZQsVumwV2zKemISVuEblAgVQ
         FREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Nf2iVqNOtbifDZcrGvUmE0lDgcMP81Su7AlPzQDta48=;
        b=q2PU6sz9/w+AlqH5qCGuH2HwywkusIjfpH+oDWYFLRRXSugz8D5b0rCCXqLi7hq1/k
         0OCNuc3fCP8F3eJDjWNlzEXBgvC3azGBqTAzQXYjFNgN0Fcz6r98znpMDIlTHsT8M+cX
         O27tPNFSgf0WDcqBuJQuMuTXn+L+V5SwKYM+GQ5cFfROFFbmBCaX10HuLj63S2U7IY0X
         vax96EhTGXrOwjieso2r0lDxyHJebC/8DmnvHmvOEurYSQ0fHamU7aLBkv92IALbmR1Y
         F6YMhdtgteD1aEgBwwTyxEu6hRBFbVXu/OhKpJI72qFH1F2IEYXcEbtmxNtdPxDGM7N7
         rhMA==
X-Gm-Message-State: APjAAAV4Tvq0qfUN876nKend/A1r4RgT7aKkTQwTK9hq7qmqLGrx2WIA
        VJFOnTO+pLIqvAaqyr5X1WeyegbQ/IGPbOW/kNgj2XzYbEI=
X-Google-Smtp-Source: APXvYqx0N9+liuC/J4Eod/7o35XcKe+UkRe1Ex6MB/eBhoOH54+PXOjsiHXW+7Za0g4t9sL+hYJhqW7hUdCfnrhIIHA=
X-Received: by 2002:a6b:da11:: with SMTP id x17mr4690096iob.78.1557245538320;
 Tue, 07 May 2019 09:12:18 -0700 (PDT)
MIME-Version: 1.0
From:   Probir Roy <proy.cse@gmail.com>
Date:   Tue, 7 May 2019 11:12:07 -0500
Message-ID: <CALe4XzYNBKhtcYvcuME0A29LvPuZEuirD3DLtHnffObRCUU8Rg@mail.gmail.com>
Subject: Locality of extent status tree traversal
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

I am running Phoronix-fio benchmark on Linux kernel 4.18.0-rc5. I
observe the same nodes have been traversed on the extent status tree
in "ext4_es_lookup_extent" function when ext4 write begins. What's the
locality signature of "ext4_es_lookup_extent" in general? Is it
possible that same logical block being looked up repeatedly
(Temporal)? Is it possible that co-located logical blocks are searched
by ext4_es_lookup_extent (spatial)?  Or is it totally random?

-- 
Probir Roy
