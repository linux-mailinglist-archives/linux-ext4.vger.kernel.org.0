Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C40FC10ECEE
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Dec 2019 17:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfLBQSn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Dec 2019 11:18:43 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:41950 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfLBQSn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Dec 2019 11:18:43 -0500
Received: by mail-pl1-f179.google.com with SMTP id bd4so119760plb.8
        for <linux-ext4@vger.kernel.org>; Mon, 02 Dec 2019 08:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lDr5P4cJ4UHd7ZMj54UzZaDvlWleENdbESvTh3swfpw=;
        b=SFZ2cXoCbyhBxZEnumr9gVKKRJyUSHgNKMl/PkvipUbkLT7mbjlw+oLbPuuxNu/raz
         OK3JoIptBAt2vnPg5nlcZ9WS8Pg3k/+HM9iBXfwBiook+l+Tdr0QNJEWjTUNIDtqk5Gk
         BZMd77IDy5czigoQWozohJjkNt393h/Ulm2woiG8fGr6j+0NcVC85zNVOLte5DV3R0IS
         5CNPPGiERoj/exEvD2E9bSjz8J9ztpOIzJCIC301yLvhOOZhxJMcNkaatDmILlz261i7
         4I5hPevVQkHnBUSbZE3m/Dne57F7kM9RyfuRHJXCgPc1yA/xswnwD/l99h6Zv0ZS/jx8
         m+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lDr5P4cJ4UHd7ZMj54UzZaDvlWleENdbESvTh3swfpw=;
        b=fuUMT/4KKgBnzmP0nIx36P4SJgLjpju7EO9ssMeWsT/FU69d2HZYUeBmheXlT9hIiy
         ZMXUpkDyZp1FT+hy5kOhc6EL44Wnd9YMSO0gB6gk1XlzcOZFIbViOewCIOEJI+ChJA4b
         npaauH/D/q5ukkzepemqh9Z+vJOqS5dnIec0sCSJHNkX65flFHeCSJuCz1ij9BWGHKA3
         5MWmxM1sTMv4XKnOVpIfH6TcBVB04jummYhqtO7iLDrtV/bAcpz8muH1q2tqUmPlbApf
         KniVYmJGGFAlFD1oXr8GvxlDcrpFGJKYawTRLs/VVYFXQDfbIM/UEqIHQ/6OL41xUk+i
         kdeA==
X-Gm-Message-State: APjAAAUNjHAOYpUy0jeGKBU4Lp4lGnoaXrGoQiEiVYkp2Yl6RYDfhBhy
        1IqtpZLnlIWvm7HoeyJIm6NLhEEUT0eFFZ8b0V2MzdBXGDU=
X-Google-Smtp-Source: APXvYqzF/QIZsDrvGOeX/F9JxX91qCzNc6BGyC7UE6gbwPQ7v0o9JY+9iIJ+58e6b7q2cwegny55kqtzxh2HgC9OYjc=
X-Received: by 2002:a17:90a:ff02:: with SMTP id ce2mr36132354pjb.117.1575303521875;
 Mon, 02 Dec 2019 08:18:41 -0800 (PST)
MIME-Version: 1.0
References: <20191127185524.40220-1-yzaikin@google.com>
In-Reply-To: <20191127185524.40220-1-yzaikin@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 2 Dec 2019 08:18:32 -0800
Message-ID: <CAFd5g44z0v5ULZeNDb=GgdaMaBO8wTCoUCp6fv0fnWEzRZuRmw@mail.gmail.com>
Subject: Re: [PATCH] fs/ext4/inode-test: Fix inode test on 32 bit platforms.
To:     Iurii Zaikin <yzaikin@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>, geert@linux-m68k.org,
        linux-ext4@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 27, 2019 at 10:55 AM Iurii Zaikin <yzaikin@google.com> wrote:
>
> Fixes the issue caused by the fact that in C in the expression
> of the form -1234L only 1234L is the actual literal, the unary
> minus is an operation applied to the literal. Which means that
> to express the lower bound for the type one has to negate the
> upper bound and subtract 1.
> Original error:
> Expected test_data[i].expected.tv_sec == timestamp.tv_sec, but
> test_data[i].expected.tv_sec == -2147483648
> timestamp.tv_sec == 2147483648
> 1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits: msb:1
> lower_bound:1 extra_bits: 0
> Expected test_data[i].expected.tv_sec == timestamp.tv_sec, but
> test_data[i].expected.tv_sec == 2147483648
> timestamp.tv_sec == 6442450944
> 2038-01-19 Lower bound of 32bit <0 timestamp, lo extra sec bit on:
> msb:1 lower_bound:1 extra_bits: 1
> Expected test_data[i].expected.tv_sec == timestamp.tv_sec, but
> test_data[i].expected.tv_sec == 6442450944
> timestamp.tv_sec == 10737418240
> 2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit on:
> msb:1 lower_bound:1 extra_bits: 2
> not ok 1 - inode_test_xtimestamp_decoding
> not ok 1 - ext4_inode_test
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Brendan Higgins <brendanhiggins@google.com>

Thanks for taking care of this so quickly!
