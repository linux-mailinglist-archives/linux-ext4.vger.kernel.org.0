Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4887D2400A5
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Aug 2020 03:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHJBCf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 9 Aug 2020 21:02:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36803 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgHJBCf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 9 Aug 2020 21:02:35 -0400
Received: from mail-qv1-f69.google.com ([209.85.219.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1k4wCv-00072Y-5c
        for linux-ext4@vger.kernel.org; Mon, 10 Aug 2020 01:02:33 +0000
Received: by mail-qv1-f69.google.com with SMTP id v18so6290726qvi.8
        for <linux-ext4@vger.kernel.org>; Sun, 09 Aug 2020 18:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=79jNt9AWXrhAF9xU8libSw5IoEPCQwOhdmwvJTGQsB8=;
        b=gdVZF55IToU7DCLdGIJbkW/O92IDw4UPq/8MMyB7OPbFaFwIoEex8gSjMxqde0MGUi
         E74Zl8fIk0Im9JBHLRd35KCy3gqoMpvf+yhjqCY0USWmeXzAlPlIVoNTVMwMvHW1wDLn
         qOMjmBVPYkqsx357bkZ+m0QS1NGHIrdsLbvauO4ZZw6CEKWVjpll38A6EFUtYEKH1dRL
         7MD3AqRmQsD5Ige1RJ84GMCQFKMk9m0Eh42Jo3YykIkDqZYg7+jJLbHdHhsZs+o6RA1e
         3y1CvCjjuviux/o9t8C4bIsidMmcLDcfEFlfYm32CtkaemyqbuAUjTlb4AnmfwjXbOU4
         5PRg==
X-Gm-Message-State: AOAM5318hYSkHBGlCuvX7vxbeZduMF2acyWcYUZMDGIa1rsABTV9hhLJ
        xySKhImU6QWBnbhmHD+T178BqcPBO5HqNXAie+rI211tF/TJqTreOqG6TPn85esR7IicMUnFF6P
        aNmlO00LWk8wwEuZ17SAsrZTX5jIUDk87T7Uc1KU=
X-Received: by 2002:a37:e92:: with SMTP id 140mr23492776qko.121.1597021352244;
        Sun, 09 Aug 2020 18:02:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZhI8NlYPXWFB5XZFvN63vqFkJWIVQ1rZoVKHssk3beaqJdaKJhEgFIbbjaiK6g64Dyjh+0Q==
X-Received: by 2002:a37:e92:: with SMTP id 140mr23492757qko.121.1597021352012;
        Sun, 09 Aug 2020 18:02:32 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id 95sm44815qtc.29.2020.08.09.18.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 18:02:31 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Mauricio Faria de Oliveira <mauricio.foliveira@gmail.com>,
        Jan Kara <jack@suse.com>
Subject: [RFC PATCH v2/TEST CASE]
Date:   Sun,  9 Aug 2020 22:02:10 -0300
Message-Id: <20200810010210.3305322-8-mfo@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810010210.3305322-1-mfo@canonical.com>
References: <20200810010210.3305322-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

#include <sys/mman.h>

int main() {
	int fd, rc;
	char *addr;
	const int PAGE_SIZE = sysconf(_SC_PAGESIZE);

	rc = unlink("file");
	if (rc < 0 && errno != ENOENT ) {
		perror("unlink");
		return 1;
	}

	fd = open("file", O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
	if (fd < 0) {
		perror("open");
		return 1;
	}

	addr = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
	if (addr < 0) {
		perror("mmap");
		return 1;
	}

	rc = pwrite(fd, "a", 1, 0);
	if (rc < 0) {
		perror("pwrite");
		close(fd);
		return 1;
	}

	addr[0] = 'B';
	addr[1] = 'U';
	addr[2] = 'G';

	while (1) {
		printf("Press enter to change buffer contents\n");
		getchar();
		addr[3]++;
		printf("Buffer contents changed\n");
	}

	// This is not reached.
	rc = munmap(addr, PAGE_SIZE);
	if (rc < 0) {
		perror("munmap");
		return 1;
	}

	close(fd);
	return 0;
}

