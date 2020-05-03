Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1A11C2C9B
	for <lists+linux-ext4@lfdr.de>; Sun,  3 May 2020 15:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgECNA2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 3 May 2020 09:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbgECNA2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 3 May 2020 09:00:28 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3060BC061A0C
        for <linux-ext4@vger.kernel.org>; Sun,  3 May 2020 06:00:28 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id s8so7281701wrt.9
        for <linux-ext4@vger.kernel.org>; Sun, 03 May 2020 06:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jguk.org; s=google;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=7OBMmC9zNBbWirf7jc1Oj9zn6Y17eITmAeWdRuMM7V4=;
        b=mHwbje1h5I9/r+PEtBuPAfmzrXyA4rMbCojJknCpCnJaNe0ojwpi14l7aFWEYJydTk
         8VdxPjKGAMeavALgsnAF6hPjC3Tmn6BmEpRY39ignTSDjLIjUpmyTOJckEXPG8tifI/6
         QatIXGTrNBHJQ3JS0eM15hE9/p8Llw4ITALw6amLl9Nf0QquGP7cu3G8tZvuiPq4iA1v
         w9hlUV13thylCn2rpTmaj+qVkubiOj7Ya1myUPbX5NlT3ClfXs/A3xCuML/5LzlL+G/O
         /APdjvBEENYyJBExIWZqfWabTpgR5sozLsbI+BGdJXAawFWKQpFRjKxqTpAQH8hDlyyY
         dn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=7OBMmC9zNBbWirf7jc1Oj9zn6Y17eITmAeWdRuMM7V4=;
        b=Fgu1ZcvbgF8p3+11RNIBiIAULYFZmxBaQty/5fghdYfnnZh6Zy40NR+0qsldlQK/UA
         fdJMenyhQOQuY986Pa/wE2ExeiVxuL3/qozAO5cX2WMcpR8M9BOjqr/dAHU7Qic2GYxQ
         UrX9mmfwtSzLDBIm8wFGb3QkSUEwJZL8HCVzTKkQKdFE4Axp/c+2fH8eGh04LQlsUquC
         hZF0vh+odiNiKaVDlzQBNfXjtqytJep/EkGRSXa7L/Lb1wg9nveutMw21Q5gznqOEuVT
         /9mzCOcN98iNlncbmpudBAtQsclwDibdlpVkEh+X4ncX5iTHfIRthkCgCU26NFbg8yIB
         K9LQ==
X-Gm-Message-State: AGi0PubkpcPdK8s+M6L4plrHjjUPkieuIJIcbqj8j/urge0Zxo5s+CBC
        xzwJRBDlEloIuOqNSFWZ0Q0zVQ==
X-Google-Smtp-Source: APiQypLbPGMI8pmDkIGgyJsCup27rF4rnBH+SPjBWtshwj1SzGoF3jeM6BxqXNqUdkyW9JAuNdgUpw==
X-Received: by 2002:a5d:5703:: with SMTP id a3mr12757046wrv.53.1588510826868;
        Sun, 03 May 2020 06:00:26 -0700 (PDT)
Received: from [192.168.0.12] (cpc87281-slou4-2-0-cust47.17-4.cable.virginm.net. [92.236.12.48])
        by smtp.gmail.com with ESMTPSA id k6sm8881051wma.19.2020.05.03.06.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2020 06:00:26 -0700 (PDT)
From:   Jonny Grant <jg@jguk.org>
Subject: /fs/ext4/namei.c ext4_find_dest_de()
To:     linux-ext4@vger.kernel.org
Message-ID: <2edc7d6a-289e-57ad-baf1-477dc240474d@jguk.org>
Date:   Sun, 3 May 2020 14:00:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi

I noticed that mkdir() returns EEXIST if a directory already exists. 
strerror(EEXIST) text is "File exists"

Can ext4_find_dest_de() be amended to return EISDIR if a directory 
already exists? This will make the error message clearer.

This is the line of code from ext4_find_dest_de():

if (ext4_match(dir, fname, de))
			return -EEXIST;



I propose to change to something like the following:


int ext4_match_result = ext4_match(dir, fname, de);

		nlen = EXT4_DIR_REC_LEN(de->name_len);
		rlen = ext4_rec_len_from_disk(de->rec_len, buf_size);
		if ((de->inode ? rlen - nlen : rlen) >= reclen)
			break;
		de = (struct ext4_dir_entry_2 *)((char *)de + rlen);

if (ext4_match_result)
{
     if(EXT4_FT_DIR == de->file_type)
     {
         return -EISDIR;
     }
     else
     {
	return -EEXIST;
     }
}



Let me know if this would be supported, and I can prepare a patch.

Cheers
Jonny
